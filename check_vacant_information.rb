# frozen_string_literal: true

# class check_vacant_information.rb
class CheckVacantInformation
  require 'open-uri'

  KENPO_URL = 'https://ks.its-kenpo.or.jp/customer/vacancies'

  TARGET_WORDS = {
    ookubo_basic_pm: '大久保　基本健診【午後】',
    ookubo_specified_am: '大久保　健保指定ドック【午前】',
    ookubo_specified_pm: '大久保　健保指定ドック【午後】',
    sanno_basic_pm: '山王　基本健診【午後】',
    sanno_specified_am: '山王　健保指定ドック【午前】',
    sanno_specified_pm: '山王　健保指定ドック【午後】'
  }.freeze

  def call # rubocop:disable Metrics/MethodLength
    results = {}
    reservation_elements.each_with_index do |elements, index|
      next unless key = include_target_words?(elements)

      reservation_info = reservation_elements[index + 1]
      extracted = extract_info(reservation_info)
      results[key] = {
        availability: extracted[:availability],
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
