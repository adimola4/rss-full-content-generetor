# frozen_string_literal: true

class AwsUploader
  require "aws-sdk-s3"

  # AWS = YAML.safe_load(File.new(Rails.root.join("gitignore", "aws-credentials.yml")))

  def initialize(rss_id, rss_location)

    @service = Aws::S3::Client.new(
      access_key_id: ENV["AWS_ACCESS_KEY_ID"].to_s,
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"].to_s,
      region: ENV["AWS_REGION"].to_s,
    )
    @rss_id = rss_id

    file = File.open(rss_location, "rb")
    @content = file.read
    @OBJkey = File.basename(rss_location.to_s)
    @bucket_name = nil
    @bucket_name = if Rails.env.production?
                     ENV["AWS_PROD_BUCKET"].to_s
                   else
                     ENV["AWS_DEV_BUCKET"].to_s
                   end
  end

  def run
    list_buckets = []
    @service.list_buckets.buckets.each do |bucket|
      list_buckets.push(bucket.name)
    end

    if list_buckets.include?(@bucket_name)

      response = @service.put_object(
        bucket: @bucket_name,
        key: @OBJkey,
        acl: "public-read",
        body: @content,
      )

      if response.etag
        url = @bucket_name + ".s3." + ENV["AWS_REGION"].to_s + ".amazonaws.com/" + @OBJkey
        rss = Rss.find(@rss_id)
        rss.generated_url = url.to_s
        return true
      else
        return false
      end
    end
    rss = Rss.find(@rss_id)
    rss.generated_url = s3_file.public_url.to_s
    rss.isready = true
    rss.save
  end
end
