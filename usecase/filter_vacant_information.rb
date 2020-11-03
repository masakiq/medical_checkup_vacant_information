# frozen_string_literal: true

# filter_vacant_information.rb
class FilterVacantInformation
  def execute(merged_vacants)
    merged_vacants.select(&:exceed_the_threshold?)
  end
end
