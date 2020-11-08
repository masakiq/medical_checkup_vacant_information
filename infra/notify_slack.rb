# frozen_string_literal: true

# NotifySlack
class NotifySlack
  def execute(payload)
    return if payload.nil? || payload.empty?

    @payload = payload
    notify_to_slack
  end

  private

  attr_reader :payload

  def notify_to_slack # rubocop:disable Metrics/MethodLength
    parms = {
      text: payload,
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
