require 'json'
unless ENV['development']
  require 'fetch_vacant_information'
  require 'check_past_data_on_s3'
end

def lambda_handler(event:, context:)
    puts FetchVacantInformation.new.call
    puts CheckPastDataOnS3.new.call
    puts CheckPastDataOnDynamodb.new.call
    { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end
