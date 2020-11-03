# frozen_string_literal: false

# notify_vacant_information.rb
class NotifyVacantInformation
  attr_reader :vacants

  def initialize(vacants)
    @vacants = vacants
  end

  def execute
    return if vacants.empty?

    body = build_body
    notify_to_slack(body)
  end

  private

  def build_body # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    body = '*空き情報が更新されました*'
    body << "\n\n"
    vacants.each do |vacant|
      body << '```'
      body << "\n"
      body << vacant.scraping_word.target_word
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
