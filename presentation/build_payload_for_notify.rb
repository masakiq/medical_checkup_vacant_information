# frozen_string_literal: false

# BuildPayloadForNotify
class BuildPayloadForNotify
  def execute(vacants)
    return if vacants.empty?

    build_payload(vacants)
  end

  private

  def build_payload(vacants) # rubocop:disable Metrics/MethodLength
    body = '*空き情報が更新されました*'
    body << "\n\n"
    vacants.each do |vacant|
      body << '```'
      body << "\n"
      body << vacant.scraping_text.body
      body << "\n"
      body << vacant.context
      body << "\n"
      body << vacant.display_diff_number
      body << "\n"
      body << '```'
      body << "\n"
    end
    body
  end
end
