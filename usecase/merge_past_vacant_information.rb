# frozen_string_literal: true

# MergePastVacantInformation
class MergePastVacantInformation
  def execute(current_vacants, past_vacants)
    merged_vacants = []
    current_vacants.each do |current_vacant|
      past_vacant = find_past_vacant_by_id(current_vacant.id, past_vacants)
      merged_vacants << VacantInformationWithPast.new(
        id: current_vacant.id,
        context: current_vacant.context,
        past_number: past_vacant.number
      )
    end
    merged_vacants
  end

  private

  def find_past_vacant_by_id(id, past_vacants)
    past_vacants.select do |vacant|
      id == vacant.id
    end.first
  end
end
