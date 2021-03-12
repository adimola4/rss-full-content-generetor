# frozen_string_literal: true

class AwsUploader
  require "aws-sdk-s3"

  AWS = YAML.safe_load(File.new(Rails.root.join("gitignore", "aws-credentials.yml")))

  def initialize(rss_id, rss_location)
    @service = Aws::S3::Client.new(
      access_key_id: AWS["aws"]["access_key_id"],
      secret_access_key: AWS["aws"]["secret_access_key"],
      region: AWS["aws"]["region"],
    )
    @rss_id = rss_id

    file = File.open(rss_location, "rb")
    @content = file.read
    @OBJkey = File.basename(rss_location.to_s)
    @bucket_name = if Rails.env.production?
                     AWS["aws"]["dev"]["bucket"]
                   else
                     AWS["aws"]["prod"]["bucket"]
                   end
    # bucket = @service.bucket(@bucket_name)
  end

  def run
    puts @bucket_name
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

        url = @bucket_name + ".s3." + AWS["aws"]["region"] + ".amazonaws.com/" + @OBJkey
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
