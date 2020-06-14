# frozen_string_literal: true

# class fetch_vacant_information.rb
class FetchVacantInformation
  require 'open-uri'
  include Constants

  KENPO_URL = 'https://ks.its-kenpo.or.jp/customer/vacancies'

  def call # rubocop:disable Metrics/MethodLength
    results = []
    reservation_elements.each_with_index do |elements, index|
      next unless key = include_target_words?(elements)

      reservation_info = reservation_elements[index + 1]
      extracted = extract_info(reservation_info)
      results << {
        id: key,
        availability: extracted[:availability] == '○',
        context: extracted[:context]
      }
    end
    results
  end

  private

  def html_elements
    content = URI.open(KENPO_URL).read
    content.split("\n").map(&:strip)
  end

  def reservation_elements
    @reservation_elements ||= html_elements.select do |e|
      e.match(/\A\<th.+?\z/) || e.match(/\A\<td.+?\z/)
    end
  end

  def include_target_words?(status)
    TARGET_WORDS.each do |key, value|
      return key if status.include?(value)
    end
    false
  end

  def extract_info(info)
    text = info.match(%r{\A\<td.+?\>(?<text>.+?)\</td\>\z})[:text]
    text.match(/\A(?<availability>[×|○])　+?(?<context>[最|現].+?)\z/)
  end
end
