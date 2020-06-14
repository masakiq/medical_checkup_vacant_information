require 'json'
unless ENV['development']
  require 'constants'
  require 'fetch_vacant_information'
  require 'update_vacant_information'
  require 'notify_to_slack'
end

def lambda_handler(event:, context:)
    info = FetchVacantInformation.new.call
    UpdateVacantInformation.new(info).call
    NotifyToSlack.new.call
    { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end
