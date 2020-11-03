# frozen_string_literal: true

require 'aws-sdk-dynamodb'

# get_vacant_information.rb
class GetVacantInformation
  def initialize
    @dynamodb = Aws::DynamoDB::Client.new
  end

  def execute
    fetch_vacant_info
  end

  private

  attr_reader :dynamodb

  def fetch_vacant_info
    vacants = []
    ScrapingWord::LIST.each_key do |id|
      item = get_item(id)
      vacants << map_vacant_info(id, item)
    end
    vacants
  end

  def get_item(id)
    dynamodb.get_item(
      table_name: VACANT_INFORMATION_TABLE,
      key: { id: id }
    ).item
  end

  def map_vacant_info(id, item)
    VacantInformation.new(
      id: id,
      context: item&.dig('context')
    )
  end
end
