# frozen_string_literal: true

# VacantWithPast
class VacantWithPast < Vacant
  attr_reader :past_number

  def initialize(id:, past_number:, context: nil)
    @past_number = past_number
    super(id: id, context: context)
  end

  def increased?
    increased_count > 2
  end

  def became_to_zero?
    number.zero? && past_number.positive?
  end

  def scraping_text
    ScrapingText.new(id: id)
  end

  def increased_count
    number - past_number
  end
end
