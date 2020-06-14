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
    updated = info[:context] != item['context']

    number = extract_number(info[:context])

    dynamodb.update_item(
      table_name: VACANT_INFO_TABLE,
      key: { id: info[:id] },
      attribute_updates: {
        availability: {
          value: info[:availability],
          action: 'PUT'
        },
        availability_past: {
          value: item['availability'],
          action: 'PUT'
        },
        context: {
          value: info[:context],
          action: 'PUT'
        },
        context_past: {
          value: item['context'],
          action: 'PUT'
        },
        number: {
          value: number,
          action: 'PUT'
        },
        number_past: {
          value: item['number'],
          action: 'PUT'
        },
        updated: {
          value: updated,
          action: 'PUT'
        }
      }
    )
  end

  def extract_number(context)
    context.match(/\A最短.+?より(?<number>\d{1,3})個の枠があります。\z/)[:number].to_i
  rescue
    0
  end

  def create_item(info)
    number = extract_number(info[:context])

    dynamodb.put_item(
      table_name: VACANT_INFO_TABLE,
      item:  {
        id:   info[:id],
        availability: info[:availability],
        availability_past: info[:availability],
        context: info[:context],
        context_past: info[:context],
        number: number,
        number_past: number,
        updated: true
      }
    )
  end
end
