require 'json'
# require 'check_vacant_information'
# require 'check_past_data_on_s3'

def lambda_handler(event:, context:)
    puts CheckVacantInformation.new.call
    puts CheckPastDataOnS3.new.call
    { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end
