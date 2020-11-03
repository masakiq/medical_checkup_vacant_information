# frozen_string_literal: true

# filter_vacant_information.rb
class FilterVacantInformation
  attr_reader :merged_vacants

  def initialize(merged_vacants)
    @merged_vacants = merged_vacants
  end

  def execute
    merged_vacants.select(&:exceed_the_threshold?)
  end
end
