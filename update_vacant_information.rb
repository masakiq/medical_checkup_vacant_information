# frozen_string_literal: true
require 'aws-sdk-dynamodb'

# update_vacant_information.rb
class UpdateVacantInformation
  include Constants

  def initialize(vacant_info)
    @client = Aws::DynamoDB::Client.new
    @vacant_info = vacant_info
  end

  def call
    update_vacant_info
  end

  private

  attr_reader :client, :vacant_info

  def update_vacant_info
    vacant_info.each do |info|
      id = info[:id]
      availability = info[:availability]
      context = info[:context]

      item = client.get_item(
        table_name: VACANT_INFO_TABLE,
        key: { id: id }
      ).item

      if item
        updated = availability != item['availability'] || context != item['context']

        client.update_item(
          table_name: VACANT_INFO_TABLE,
          key: { id: id },
          attribute_updates: {
            availability: {
              value: availability,
              action: 'PUT'
            },
            context: {
              value: context,
              action: 'PUT'
            },
            updated: {
              value: updated,
              action: 'PUT'
            }
          }
        )
      else
        client.put_item(
          table_name: VACANT_INFO_TABLE,
          item:  {
            id:   id,
            availability: availability,
            context: context,
            updated: true
          }
        )
      end
    end
  end
end
