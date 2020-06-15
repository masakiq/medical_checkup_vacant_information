require 'aws-sdk-dynamodb'

# notify_to_slack.rb
class NotifyToSlack
  include Constants

  def initialize
    @dynamodb = Aws::DynamoDB::Client.new
  end

  def call
    items = fetch_updated_items
    items = truncate_items_with_fewer_diff(items)
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

  def truncate_items_with_fewer_diff(items)
    items.select do |item|
      item['availability'].to_s != item['availability_past'].to_s ||
        item['stacked_diff_number'].to_i != item['stacked_diff_number_past'].to_i
    end
  end

  def build_body(items)
    body = '*空き情報が更新されました*'
    body << "\n\n"
    items.each do |item|
      next unless item['updated']
      body << '```'
      body << "\n"
      body << TARGET_WORDS[item['id'].to_sym]
      body << "\n"
      body << item['context']
      body << "\n"
      body << "前回との枠の増減は #{item['stacked_diff_number_past'].to_i} です。"
      body << "\n"
      body << '```'
      body << "\n"
    end
    body
  end

  def notify_to_slack(body)
    puts body
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

    response = http.request(request)
  end
end
