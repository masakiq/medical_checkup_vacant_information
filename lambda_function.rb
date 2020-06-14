require 'json'
unless ENV['development']
  require 'check_vacant_information'
  require 'check_past_data_on_s3'
end

def lambda_handler(event:, context:)
    puts CheckVacantInformation.new.call
    puts CheckPastDataOnS3.new.call
    puts CheckPastDataOnDynamodb.new.call
    { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end
