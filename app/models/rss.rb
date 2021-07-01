# frozen_string_literal: true

class Rss < ApplicationRecord
  # require_relative('../../../services/aws_uploader')
  # AWS = YAML.safe_load(File.new(Rails.root.join("gitignore", "aws-credentials.yml")))

  validates :title, presence: { base: "Title can't be blank!" }
  validates :title, length: { maximum: 255 }
  validates :original_url, presence: { base: "Url can't be blank!" }
  validates :original_url, length: { maximum: 255 }
  validates :original_url, uniqueness: true

  after_create :rss_fetch
  def rss_fetch
    RssFetchWorker.perform_async(id)
  end

  def self.get_feed(rss)
    return nil if rss.nil?

    @articles = RssFetcher.new(rss).run
    file_name = rss.title unless rss.title.nil?
    rss.generated_url = rss.initial_aws(file_name) if rss.generated_url.nil?
    path_string = rss.create_rss_file(rss, @articles, file_name)
    AwsUploader.new(rss.id, path_string).run
    File.delete(path_string)
  end

  def initial_aws(file_name)
    bucket_name = if Rails.env.production?
                    ENV["AWS_PROD_BUCKET"].to_s
                  else
                    ENV["AWS_DEV_BUCKET"].to_s
                  end
    if file_name.nil?
      puts "file_name", file_name
    end
    url = bucket_name + ".s3." + ENV["AWS_REGION"].to_s + ".amazonaws.com/rss_files" + file_name + "3.xml"
    url
  end

  def create_rss_file(rss, articles, file_name)
    data = ApplicationController.render(
      template: "rss/rss",
      assigns: { rss: rss, articles: articles },
    )

    dir = File.dirname("#{Rails.root}/tmp/rss_files/aaa/")
    path_string = dir.to_s + file_name.to_s + "3.xml"
    file = File.open(path_string, "wb")
    file.write(data)
    file.close
    path_string
  end
end
