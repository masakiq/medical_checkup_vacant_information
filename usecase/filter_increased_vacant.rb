# frozen_string_literal: true

# FilterIncreasedVacant
class FilterIncreasedVacant
  def execute(merged_vacants)
    merged_vacants.select(&:increased?)
  end
end
