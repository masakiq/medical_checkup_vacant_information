# frozen_string_literal: false

# NotifyVacantInformation
class NotifyVacantInformation < AbstractNotifyVacantInformation
  def execute(vacants)
    return if vacants.empty?

    body = build_body(vacants)
    notify_to_slack(body)
  end

  private

  def build_body(vacants) # rubocop:disable Metrics/MethodLength
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

  def notify_to_slack(body) # rubocop:disable Metrics/MethodLength
    parms = {
      text: body,
      channel: '#medical_booking',
      username: 'Medical Booking Bot',
      icon_emoji: ':hospital:'
    }

    uri = URI.parse(ENV['SLACK_WEBHOOK_URL'])
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = parms.to_json

    http.request(request)
  end
end
