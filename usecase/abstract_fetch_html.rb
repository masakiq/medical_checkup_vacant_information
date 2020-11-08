# frozen_string_literal: true

# AbstractFetchHtml
class AbstractFetchHtml
  # @param url [String] Target url
  # @return [Array<String>] HTML data for the target page
  def execute(_url)
    raise NotImplementedError, "Not implemented #{self.class}##{__method__}!!"
  end
end
