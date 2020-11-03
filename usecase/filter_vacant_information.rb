# frozen_string_literal: true

# filter_vacant_information.rb
class FilterVacantInformation
  def execute(merged_vacants)
    merged_vacants.select(&:reached_the_value_to_be_notified?)
  end
end
