# frozen_string_literal: true

require 'aws-sdk-s3'
# check_past_data_on_s3.rb
class CheckPastDataOnS3
  def call
    s3 = Aws::S3::Client.new
    resp = s3.list_buckets
    resp.buckets.map(&:name)
  end
end
