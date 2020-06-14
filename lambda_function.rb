require 'json'
unless ENV['development']
  require 'fetch_vacant_information'
  require 'check_past_data_on_s3'
end

def lambda_handler(event:, context:)
    info = FetchVacantInformation.new.call
    UpdateVacantInformation.new(info).call
    { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end
