# frozen_string_literal: true

# PersistVacant
class PersistVacant
  def execute(vacants)
    vacants.each do |vacant|
      item = VacantRepository.new.find(id: vacant.id)
      if item
        VacantRepository.new.update(vacant: vacant)
      else
        VacantRepository.new.create(vacant: vacant)
      end
    end
  end
end
