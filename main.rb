load 'lambda_function.rb'
load 'fetch_vacant_information.rb'
load 'check_past_data_on_s3.rb'
load 'update_vacant_information.rb'
require 'pry'

lambda_handler(event: {}, context: {})
