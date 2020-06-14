load 'lambda_function.rb'
load 'fetch_vacant_information.rb'
load 'update_vacant_information.rb'
require 'pry'

lambda_handler(event: {}, context: {})
