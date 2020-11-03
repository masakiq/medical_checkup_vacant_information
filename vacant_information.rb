# frozen_string_literal: true

# vacant_information.rb
class VacantInformation
  attr_reader :id, :context

  def initialize(id:, context: '現在のところ空きがありません。')
    @id = id.to_s
    @context = context
    validate_id!
  end

  def number
    context.match(/\A最短.+?より(?<number>\d{1,3})個の枠があります。\z/)[:number].to_i
  rescue StandardError
    0
  end

  private

  def validate_id!
    return if ScrapingWord::LIST.keys.map(&:to_s).include?(id)

    raise StandardError, 'invalid id'
  end
end
