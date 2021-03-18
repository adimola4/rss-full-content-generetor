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
    file_name = rss.title.gsub!(/\s+/, "") || rss.title
    rss.generated_url = rss.initial_aws(file_name)
    path_string = rss.create_rss_file(rss, @articles, file_name)
    AwsUploader.new(rss.id, path_string).run
    File.delete(path_string)
  end

  def initial_aws(file_name)
    if Rails.env.production?
      bucket_name = AWS["aws"]["dev"]["bucket"]
    else
      bucket_name = AWS["aws"]["prod"]["bucket"]
    end
    if file_name.nil?
      puts "file_name",file_name
    end
    url = bucket_name + ".s3." + AWS["aws"]["region"] + ".amazonaws.com/" + file_name + ".xml"
    return url
  end

  def create_rss_file(rss, articles, file_name)
    data = ApplicationController.render(
      template: "rss/rss",
      assigns: { rss: rss, articles: articles },
    )
    dir = Rails.root.join("tmp", "rss_files/aaa/")
    Dir.mkdir(dir) unless Dir.exist?(dir)
    path_string = dir.to_s + file_name.to_s + "3.xml"
    file = File.open(path_string, "wb")
    file.write(data)
    file.close
    return path_string
  end
    
    
end
