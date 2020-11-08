# frozen_string_literal: true

# FetchHtml
class FetchHtml < AbstractFetchHtml
  require 'open-uri'

  # @param url [String] Target url
  # @return [Array<String>] description
  def execute(url)
    content = OpenURI.open_uri(url).read
    content.split("\n").map(&:strip)
  end
end
