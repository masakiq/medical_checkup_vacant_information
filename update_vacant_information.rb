# frozen_string_literal: true
require 'aws-sdk-dynamodb'

# update_vacant_information.rb
class UpdateVacantInformation
  include Constants

  def initialize(vacant_info)
    @dynamodb = Aws::DynamoDB::Client.new
    @vacant_info = vacant_info
  end

  def call
    update_vacant_info
  end

  private

  attr_reader :dynamodb, :vacant_info

  def update_vacant_info
    vacant_info.each do |info|
      item = get_item(info)
      if item
        update_item(item, info)
      else
        create_item(info)
      end
    end
  end

  def get_item(info)
    dynamodb.get_item(
      table_name: VACANT_INFO_TABLE,
      key: { id: info[:id] }
    ).item
  end

  def update_item(item, info)
    updated = info[:availability] != item['availability'] || info[:context] != item['context']

    dynamodb.update_item(
      table_name: VACANT_INFO_TABLE,
      key: { id: info[:id] },
      attribute_updates: {
        availability: {
          value: info[:availability],
          action: 'PUT'
        },
        context: {
          value: info[:context],
          action: 'PUT'
        },
        updated: {
          value: updated,
          action: 'PUT'
        }
      }
    )
  end

  def create_item(info)
    dynamodb.put_item(
      table_name: VACANT_INFO_TABLE,
      item:  {
        id:   info[:id],
        availability: info[:availability],
        context: info[:context],
        updated: true
      }
    )
  end
end
