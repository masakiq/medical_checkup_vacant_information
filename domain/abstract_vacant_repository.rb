# frozen_string_literal: true

# AbstractVacantRepository
class AbstractVacantRepository
  def find_all
    raise NotImplementedError, "Not implemented #{self.class}##{__method__}!!"
  end

  def find(id:) # rubocop:disable Lint/UnusedMethodArgument
    raise NotImplementedError, "Not implemented #{self.class}##{__method__}!!"
  end

  def update(vacant:) # rubocop:disable Lint/UnusedMethodArgument
    raise NotImplementedError, "Not implemented #{self.class}##{__method__}!!"
  end

  def create(vacant:) # rubocop:disable Lint/UnusedMethodArgument
    raise NotImplementedError, "Not implemented #{self.class}##{__method__}!!"
  end
end
