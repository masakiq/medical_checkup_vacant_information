# frozen_string_literal: true

require 'json'
unless ENV['development']
  Dir["#{File.dirname(__FILE__)}/domain/*.rb"].sort.each { |file| require file }
  Dir["#{File.dirname(__FILE__)}/usecase/*.rb"].sort.each { |file| require file }
  Dir["#{File.dirname(__FILE__)}/infra/*.rb"].sort.each { |file| require file }
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
