# frozen_string_literal: true

# FetchHtml
class FetchHtml < AbstractFetchHtml
  require 'open-uri'

  # @param url [String] Target url
  # @return [Array<String>] description
  def self.execute
    content = OpenURI.open_uri(ENV['KENPO_URL']).read
    content.split("\n").map(&:strip)
  end
end
