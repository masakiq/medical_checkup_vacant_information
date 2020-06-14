load 'lambda_function.rb'
load 'constants.rb'
load 'fetch_vacant_information.rb'
load 'update_vacant_information.rb'
load 'notify_to_slack.rb'
require 'pry'

lambda_handler(event: {}, context: {})
