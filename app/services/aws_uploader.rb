# frozen_string_literal: true

class AwsUploader
  require "aws-sdk-s3"

  # AWS = YAML.safe_load(File.new(Rails.root.join("gitignore", "aws-credentials.yml")))

  def initialize(rss_id, rss_location)
    puts ״דגכדגכדג״,ENV["AWS_ACCESS_KEY_ID"].to_s, ENV["AWS_REGION"].to_s

    @service = Aws::S3::Client.new(
      access_key_id: ENV["AWS_ACCESS_KEY_ID"].to_s,
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"].to_s,
      region: ENV["AWS_REGION"].to_s,
    )
    # puts @service.list_buckets
    @rss_id = rss_id

    file = File.open(rss_location, "rb")
    @content = file.read
    @OBJkey = File.basename(rss_location.to_s)
    @bucket_name = nil;
    if Rails.env.production?
      @bucket_name = ENV["AWS_PROD_BUCKET"].to_s
    else
      @bucket_name = ENV["AWS_DEV_BUCKET"].to_s
    end
    # bucket = @service.bucket(@bucket_name)
  end

  def run
    
    # puts @service.list_buckets.methods
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
        puts "Object '#{@OBJkey}' uploaded to bucket '#{@bucket_name}'."
        puts response.data

        url = @bucket_name + ".s3." + ENV["AWS_REGION"].to_s + ".amazonaws.com/" + @OBJkey
        puts url
        rss = Rss.find(@rss_id)
        rss.generated_url = url.to_s
        p rss.save

        return true
      else
        return false
      end
    # bucket = @service.list_buckets.buckets[@bucket_name]
    else

      # bucket = @service.list_buckets(@bucket_name)
    end
    rss = Rss.find(@rss_id)
    rss.generated_url = s3_file.public_url.to_s
    rss.isready = true
    p rss.save
  end
end
