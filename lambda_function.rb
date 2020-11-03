# frozen_string_literal: true

require 'json'
unless ENV['development']
  require 'domain/scraping_word'
  require 'domain/vacant_information'
  require 'domain/vacant_information_with_past'
  require 'domain/abstract_vacant_information_repository'
  require 'usecase/persist_vacant_information'
  require 'usecase/merge_past_vacant_information'
  require 'usecase/filter_vacant_information'
  require 'usecase/abstract_scraping_vacant_information'
  require 'usecase/abstract_notify_vacant_information'
  require 'infra/vacant_information_repository'
  require 'infra/scraping_vacant_information'
  require 'infra/notify_vacant_information'
end

def lambda_handler(event:, context:) # rubocop:disable Lint/UnusedMethodArgument
  current_vacants = ScrapingVacantInformation.new.execute
  past_vacants = VacantInformationRepository.new.find_all
  merged_vacants = MergePastVacantInformation.new.execute(current_vacants, past_vacants)
  filtered_vacants = FilterVacantInformation.new.execute(merged_vacants)
  NotifyVacantInformation.new.execute(filtered_vacants)
  PersistVacantInformation.new.execute(current_vacants)
  { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end
