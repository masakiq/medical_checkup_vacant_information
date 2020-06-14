# frozen_string_literal: true

require 'aws-sdk-s3'
# check_past_data_on_s3.rb
class CheckPastDataOnS3
  def initialize
    @client = Aws::S3::Client.new
  end

  def call
    hogehoge('hoge')
  end

  private

  attr_reader :client

  def fuga
    resp = client.list_buckets
    resp.buckets.map(&:name)
  end

  def hoge
    resp = client.list_objects({
      bucket: 'logs-portfolio',
      max_keys: 2,
    })
  end

  def hogehoge(key)
    resp = client.get_object({
      bucket: 'medical-checkup-vacant-information',
      key: key,
      range: 'bytes=0-9',
    })
  rescue Aws::S3::Errors::NoSuchKey => e
    puts 'no such key'
  end
end
