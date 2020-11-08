# frozen_string_literal: true

# AbstractFetchHtml
class AbstractFetchHtml
  KENPO_URL = 'https://ks.its-kenpo.or.jp/customer/vacancies'

  # @return [Array<String>] HTML data for the target page
  def execute
    raise NotImplementedError, "Not implemented #{self.class}##{__method__}!!"
  end
end
