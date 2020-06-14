require 'json'
require 'check_vacant_information'

def lambda_handler(event:, context:)
    puts CheckVacantInformation.new.call
    { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end
