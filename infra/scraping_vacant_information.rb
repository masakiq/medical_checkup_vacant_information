# frozen_string_literal: true

# class AbstractScrapingVacantInformation
class ScrapingVacantInformation < AbstractScrapingVacantInformation
  require 'open-uri'

  def execute
    vacants = []
    reservation_elements.each_with_index do |elements, index|
      id = vacant_id_if_include_target_wrod(elements)
      next unless id

      reservation_info = reservation_elements[index + 1]
      extracted = extract_info(reservation_info)

      context = extracted[:context]
      vacants << map_vacant_info(id, context)
    end
    vacants
  end

  private

  def map_vacant_info(id, context)
    VacantInformation.new(id: id, context: context)
  end

  def html_elements
    content = OpenURI.open_uri(KENPO_URL).read
    content.split("\n").map(&:strip)
  end

  def reservation_elements
    @reservation_elements ||= html_elements.select do |e|
      e.match(/\A<th.+?\z/) || e.match(/\A<td.+?\z/)
    end
  end

  def vacant_id_if_include_target_wrod(elements)
    ScrapingText::LIST.each do |id, value|
      return id if elements.include?(value)
    end
    false
  end

  def extract_info(info)
    text = info.match(%r{\A<td.+?>(?<text>.+?)</td>\z})[:text]
    text.match(/\A.+?(?<context>[最短|現在].+?)\z/)
  end
end
