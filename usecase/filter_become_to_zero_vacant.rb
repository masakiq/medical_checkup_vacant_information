# frozen_string_literal: true

# FilterBecomeToZeroVacant
class FilterBecomeToZeroVacant
  def execute(merged_vacants)
    merged_vacants.select(&:became_to_zero?)
  end
end
