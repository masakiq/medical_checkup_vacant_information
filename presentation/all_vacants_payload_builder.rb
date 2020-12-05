# frozen_string_literal: false

# AllVacantsPayloadBuilder
class AllVacantsPayloadBuilder
  def execute(vacants, increased_vacants, become_to_zero_vacants)
    count = increased_vacants.size + become_to_zero_vacants.size
    return if count.zero?
    return if vacants.empty?

    build_payload(vacants)
  end

  private

  def build_payload(vacants) # rubocop:disable Metrics/MethodLength
    body = '*全体の空き状況*'
    body << "\n\n"
    body << '```'
    body << "\n"
    vacants.each do |vacant|
      body << vacant.scraping_text.body.tr('1X', '１Ｘ').ljust(25, '　')
      body << vacant.context
      body << "\n"
    end
    body << '```'
    body << "\n"
    body
  end
end
