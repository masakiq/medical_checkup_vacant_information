# frozen_string_literal: true

# PersistVacantInformation
class PersistVacantInformation
  def initialize(vacants)
    @vacants = vacants
  end

  def execute
    vacants.each do |vacant|
      item = VacantInformationRepository.new.find(id: vacant.id)
      if item
        VacantInformationRepository.new.update(vacant: vacant)
      else
        VacantInformationRepository.new.create(vacant: vacant)
      end
    end
  end

  private

  attr_reader :vacants
end
