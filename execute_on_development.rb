# frozen_string_literal: true

load 'lambda_function.rb'
load 'scraping_word.rb'
load 'vacant_information.rb'
load 'vacant_information_with_past.rb'
load 'vacant_information_table.rb'
load 'scraping_vacant_information.rb'
load 'get_vacant_information.rb'
load 'merge_past_vacant_information.rb'
load 'filter_vacant_information.rb'
load 'notify_vacant_information.rb'
load 'update_vacant_information.rb'
require 'pry'

lambda_handler(event: {}, context: {})
