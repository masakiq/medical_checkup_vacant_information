# frozen_string_literal: false

# IncreasedVacantPayloadBuilder
class IncreasedVacantPayloadBuilder
  def execute(vacants)
    return if vacants.empty?

    build_payload(vacants)
  end

  private

  def build_payload(vacants) # rubocop:disable Metrics/MethodLength
    body = '*空きが増えました*'
    body << "\n\n"
    vacants.each do |vacant|
      body << '```'
      body << "\n"
      body << vacant.scraping_text.body
      body << "\n"
      body << vacant.context
      body << "\n"
      body << '```'
      body << "\n"
    end
    body
  end
end
