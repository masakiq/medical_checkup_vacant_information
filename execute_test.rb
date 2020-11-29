# frozen_string_literal: true

ENV['test'] = 'true'
require 'test/unit'
begin
  require 'pry'
rescue LoadError
  puts 'Does not exists `pry`'
end

load 'domain/vacant.rb'
load 'domain/vacant_with_past.rb'
load 'domain/scraping_text.rb'
load 'presentation/increased_vacant_payload_builder.rb'
load 'usecase/abstract_scraping_vacant.rb'
load 'infra/scraping_vacant.rb'
load 'usecase/abstract_fetch_html.rb'
load 'infra/fetch_html.rb'
load 'test/domain/vacant_test.rb'
load 'test/domain/vacant_with_past_test.rb'
load 'test/presentation/increased_vacant_payload_builder_test.rb'
load 'test/infra/scraping_vacant_test.rb'
