# frozen_string_literal: true

require 'aws-sdk-dynamodb'

# VacantInformationRepository
class VacantInformationRepository < AbstractVacantInformationRepository
  VACANT_INFORMATION_TABLE =
    if ENV['development']
      'medical_checkup_vacant_information_development'
    elsif ENV['staging']
      'medical_checkup_vacant_information_staging'
    else
      'medical_checkup_vacant_information'
    end

  def initialize
    @dynamodb = Aws::DynamoDB::Client.new
    super
  end

  def find_all
    vacants = []
    ScrapingWord::LIST.each_key do |id|
      item = find(id: id)
      vacants << map_vacant_info(id, item)
    end
    vacants
  end

  def find(id:)
    dynamodb.get_item(
      table_name: VACANT_INFORMATION_TABLE,
      key: { id: id }
    ).item
  end

  def update(vacant:)
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

  def create(vacant:)
    dynamodb.put_item(
      table_name: VACANT_INFORMATION_TABLE,
      item: {
        id: vacant.id,
        context: vacant.context
      }
    )
  end

  private

  attr_reader :dynamodb

  def map_vacant_info(id, item)
    VacantInformation.new(
      id: id,
      context: item&.dig('context')
    )
  end
end
