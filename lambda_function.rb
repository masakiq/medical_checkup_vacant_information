require 'json'
unless ENV['development']
  require 'fetch_vacant_information'
  require 'update_vacant_information'
end

def lambda_handler(event:, context:)
    info = FetchVacantInformation.new.call
    UpdateVacantInformation.new(info).call
    { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end
