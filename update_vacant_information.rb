# frozen_string_literal: true

require 'aws-sdk-dynamodb'

# update_vacant_information.rb
class UpdateVacantInformation
  def initialize(vacants)
    @dynamodb = Aws::DynamoDB::Client.new
    @vacants = vacants
  end

  def execute
    update_vacants
  end

  private

  attr_reader :dynamodb, :vacants

  def update_vacants
    vacants.each do |vacant|
      item = get_item(vacant)
      if item
        update_item(vacant)
      else
        create_item(vacant)
      end
    end
  end

  def get_item(vacant)
    dynamodb.get_item(
      table_name: VACANT_INFORMATION_TABLE,
      key: { id: vacant.id }
    ).item
  end

  def update_item(vacant)
    dynamodb.update_item(
      table_name: VACANT_INFORMATION_TABLE,
      key: { id: vacant.id },
      attribute_updates: {
        context: {
          value: vacant.context,
          action: 'PUT'
        }
      }
    )
  end

  def create_item(vacant)
    dynamodb.put_item(
      table_name: VACANT_INFORMATION_TABLE,
      item: {
        id: vacant.id,
        context: vacant.context
      }
    )
  end
end
