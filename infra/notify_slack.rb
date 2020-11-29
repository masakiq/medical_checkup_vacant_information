# frozen_string_literal: true

# NotifySlack
class NotifySlack
  def execute(payload:, icon_emoji: ':hospital:')
    return if payload.nil? || payload.empty?

    notify_to_slack(payload, icon_emoji)
  end

  private

  def notify_to_slack(payload, icon_emoji) # rubocop:disable Metrics/MethodLength
    parms = {
      text: payload,
      channel: '#medical_booking',
      username: 'Medical Booking Bot',
      icon_emoji: icon_emoji
    }

    uri = URI.parse(ENV['SLACK_WEBHOOK_URL'])
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = parms.to_json

    http.request(request)
  end
end
