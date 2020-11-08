# frozen_string_literal: true

# FetchHtml
class FetchHtml < AbstractFetchHtml
  # @return [Array<String>] description
  def execute
    content = OpenURI.open_uri(KENPO_URL).read
    content.split("\n").map(&:strip)
  end
end
