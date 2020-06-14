# frozen_string_literal: true

# require 'aws-sdk-s3'
require 'aws-sdk-dynamodb'
# check_past_data_on_dynamodb.rb
class CheckPastDataOnDynamodb
  TABLE = 'medical_checkup_vacant_information'

  def initialize
    @client = Aws::DynamoDB::Client.new
  end

  def call
    fuga
  end

  private

  attr_reader :client

  def hoge
    client.put_item(
      table_name: TABLE,
      item:  {
        id:   'hoge',
        availability: false,
        context: 'hogehoge',
        updated: false
      }
    )
  end

  def fuga
    result = client.get_item(
      table_name: TABLE,
      key: {
        id: 'hoge'
      }
    )

    result.item.each do |key, value|
      puts "#{key}: #{value}"
    end
  end
end
