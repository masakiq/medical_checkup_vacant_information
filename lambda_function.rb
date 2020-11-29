# frozen_string_literal: true

require 'json'
unless ENV['development']
  Dir["#{File.dirname(__FILE__)}/domain/*.rb"].sort.each { |file| require file }
  Dir["#{File.dirname(__FILE__)}/usecase/*.rb"].sort.each { |file| require file }
  Dir["#{File.dirname(__FILE__)}/infra/*.rb"].sort.each { |file| require file }
  Dir["#{File.dirname(__FILE__)}/presentation/*.rb"].sort.each { |file| require file }
end

def lambda_handler(event:, context:) # rubocop:disable Lint/UnusedMethodArgument,Metrics/AbcSize,Metrics/MethodLength
  # get current vacants
  html_elements = FetchHtml.execute
  current_vacants = ScrapingVacant.execute(html_elements)

  # get past vacants
  past_vacants = VacantRepository.new.find_all

  # merge past_number to current vacants
  merged_vacants = MergePastNumberToCurrentVacant.new.execute(current_vacants, past_vacants)

  # filter vacants
  increased_vacants = FilterIncreasedVacant.new.execute(merged_vacants)
  become_to_zero_vacants = FilterBecomeToZeroVacant.new.execute(merged_vacants)

  # build payload
  increased_vacant_payload = IncreasedVacantPayloadBuilder.new.execute(increased_vacants)
  become_to_zero_vacant_payload = BecomeToZeroVacantPayloadBuilder.new.execute(become_to_zero_vacants)

  # notify to slack
  slack_notifier = NotifySlack.new
  slack_notifier.execute(payload: increased_vacant_payload, icon_emoji: 'zou')
  slack_notifier.execute(payload: become_to_zero_vacant_payload, icon_emoji: 'gen')

  # persist vacants
  PersistVacant.new.execute(current_vacants)

  { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end
