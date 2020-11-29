# frozen_string_literal: true

require 'json'
unless ENV['development']
  Dir["#{File.dirname(__FILE__)}/domain/*.rb"].sort.each { |file| require file }
  Dir["#{File.dirname(__FILE__)}/usecase/*.rb"].sort.each { |file| require file }
  Dir["#{File.dirname(__FILE__)}/infra/*.rb"].sort.each { |file| require file }
  Dir["#{File.dirname(__FILE__)}/presentation/*.rb"].sort.each { |file| require file }
end

def lambda_handler(event:, context:) # rubocop:disable Lint/UnusedMethodArgument,Metrics/AbcSize,Metrics/MethodLength
  html_elements = FetchHtml.execute
  current_vacants = ScrapingVacant.execute(html_elements)
  past_vacants = VacantRepository.new.find_all
  merged_vacants = MergePastNumberToCurrentVacant.new.execute(current_vacants, past_vacants)
  filter_increased_vacants = FilterIncreasedVacant.new.execute(merged_vacants)
  filter_become_to_zero_vacants = FilterBecomeToZeroVacant.new.execute(merged_vacants)
  increased_vacant_payload = IncreasedVacantPayloadBuilder.new.execute(filter_increased_vacants)
  become_to_zero_vacant_payload = BecomeToZeroVacantPayloadBuilder.new.execute(filter_become_to_zero_vacants)
  slack_notifier = NotifySlack.new
  slack_notifier.execute(payload: increased_vacant_payload, icon_emoji: 'zou')
  slack_notifier.execute(payload: become_to_zero_vacant_payload, icon_emoji: 'gen')
  PersistVacant.new.execute(current_vacants)
  { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end
