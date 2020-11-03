# frozen_string_literal: true

require 'json'
unless ENV['development']
  require 'domain/scraping_word'
  require 'domain/vacant_information'
  require 'domain/vacant_information_with_past'
  require 'domain/abstract_vacant_information_repository'
  require 'vacant_information_table'
  require 'scraping_vacant_information'
  require 'get_vacant_information'
  require 'merge_past_vacant_information'
  require 'filter_vacant_information'
  require 'notify_vacant_information'
  require 'update_vacant_information'
end

def lambda_handler(event:, context:) # rubocop:disable Lint/UnusedMethodArgument
  current_vacants = ScrapingVacantInformation.new.execute
  past_vacants = GetVacantInformation.new.execute
  merged_vacants = MergePastVacantInformation.new(current_vacants, past_vacants).execute
  filtered_vacants = FilterVacantInformation.new(merged_vacants).execute
  NotifyVacantInformation.new(filtered_vacants).execute
  UpdateVacantInformation.new(current_vacants).execute
  { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end
