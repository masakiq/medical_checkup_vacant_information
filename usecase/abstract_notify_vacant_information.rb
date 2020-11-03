# frozen_string_literal: true

# AbstractNotifyVacantInformation
class AbstractNotifyVacantInformation
  def execute(vacants) # rubocop:disable Lint/UnusedMethodArgument
    raise NotImplementedError, "Not implemented #{self.class}##{__method__}!!"
  end
end
