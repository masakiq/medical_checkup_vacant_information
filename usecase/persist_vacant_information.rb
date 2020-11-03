# frozen_string_literal: true

# PersistVacantInformation
class PersistVacantInformation
  def execute(vacants)
    vacants.each do |vacant|
      item = VacantInformationRepository.new.find(id: vacant.id)
      if item
        VacantInformationRepository.new.update(vacant: vacant)
      else
        VacantInformationRepository.new.create(vacant: vacant)
      end
    end
  end
end
