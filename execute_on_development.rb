# frozen_string_literal: true

require './lambda_function'
Dir["#{File.dirname(__FILE__)}/domain/*.rb"].sort.each { |file| require file }
Dir["#{File.dirname(__FILE__)}/usecase/*.rb"].sort.each { |file| require file }
Dir["#{File.dirname(__FILE__)}/infra/*.rb"].sort.each { |file| require file }
require 'pry'

lambda_handler(event: {}, context: {})
