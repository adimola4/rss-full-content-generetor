# frozen_string_literal: true

class Rss < ApplicationRecord
  # require_relative('../../../services/aws_uploader')
  AWS = YAML.safe_load(File.new(Rails.root.join("gitignore", "aws-credentials.yml")))

  validates :title, presence: { base: "Title can't be blank!" }
  validates :title, length: { maximum: 255 }
  validates :original_url, presence: { base: "Url can't be blank!" }
  validates :original_url, length: { maximum: 255 }
  validates :original_url, uniqueness: true

  after_create :rss_fetch
  def rss_fetch
    RssFetchWorker.perform_async(self.id)
  end

  def self.get_feed(rss)
    return nil if rss.nil?

    @articles = RssFetcher.new(rss).run
    file_name = rss.title.gsub!(/\s+/, "")
    bucket_name = if Rails.env.production?
                    AWS["aws"]["dev"]["bucket"]
                  else
                    AWS["aws"]["prod"]["bucket"]
                  end
    url = bucket_name + ".s3." + AWS["aws"]["region"] + ".amazonaws.com/" + file_name + ".xml"

    rss.generated_url = url
    data = ApplicationController.render(
      template: "rss/rss",

      assigns: { rss: rss, articles: @articles },
    )

    # p Rails.root
    dir = Rails.root.join("tmp", "rss_files/aaa/")
    Dir.mkdir(dir) unless Dir.exist?(dir)
    path_string = dir.to_s + file_name.to_s + "3.xml"
    file = File.open(path_string, "wb")
    file.write(data)
    file.close

    AwsUploader.new(rss.id, path_string).run
    File.delete(path_string)
    end

      #   def self.update_rss(rss)
      #     return if rss.nil? || rss.generated_url.length < 10
      #     @articles = RssFetcher.new(rss).run

      #   end
    end
