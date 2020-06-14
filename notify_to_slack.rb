require 'aws-sdk-dynamodb'

# notify_to_slack.rb
class NotifyToSlack
  include Constants

  def initialize
    @dynamodb = Aws::DynamoDB::Client.new
  end

  def call
    items = fetch_updated_items
    return if items.size == 0
    body = build_body(items)
    notify_to_slack(body)
  end

  private

  attr_reader :dynamodb

  def fetch_updated_items
    TARGET_WORDS.keys.map do |key|
      dynamodb.get_item(
        table_name: VACANT_INFO_TABLE,
        key: { id: key }
      ).item
    end.select do |item|
      item['updated']
    end
  end

  def build_body(items)
    body = '*空き情報が更新されました*'
    body << "\n\n"
    body << '```'
    items.each do |item|
      next unless item['updated']
      body << "\n"
      body << TARGET_WORDS[item['id'].to_sym]
      body << "\n"
      body << item['context']
      body << "\n"
    end
    body << '```'
  end

  def notify_to_slack(body)
    parms = {
      text: body,
      channel: '#medical_booking_ookubo_basic_pm',
      username: 'Medical Booking Bot',
      icon_emoji: ':hospital:'
    }

    uri = URI.parse(ENV['SLACK_WEBHOOK_URL'])
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = parms.to_json

    response = http.request(request)
  end
end