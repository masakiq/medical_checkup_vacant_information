load 'lambda_function.rb'
load 'check_vacant_information.rb'
load 'check_past_data_on_s3.rb'
load 'check_past_data_on_dynamodb.rb'

lambda_handler(event: {}, context: {})
