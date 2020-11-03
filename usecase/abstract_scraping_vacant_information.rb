# frozen_string_literal: true

# AbstractScrapingVacantInformation
class AbstractScrapingVacantInformation
  KENPO_URL = 'https://ks.its-kenpo.or.jp/customer/vacancies'

  def execute
    raise NotImplementedError, "Not implemented #{self.class}##{__method__}!!"
  end
end
