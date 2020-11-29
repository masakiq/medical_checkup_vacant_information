# frozen_string_literal: true

# FetchHtml
class FetchHtml < AbstractFetchHtml
  require 'open-uri'

  KENPO_URL = 'https://ks.its-kenpo.or.jp/customer/vacancies'

  # @param url [String] Target url
  # @return [Array<String>] description
  def self.execute
    content = OpenURI.open_uri(KENPO_URL).read
    content.split("\n").map(&:strip)
  end
end
