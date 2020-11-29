# frozen_string_literal: true

# AbstractScrapingVacant
class AbstractScrapingVacant
  def self.execute
    raise NotImplementedError, "Not implemented #{self.class}##{__method__}!!"
  end
end
