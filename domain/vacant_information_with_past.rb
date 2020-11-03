# frozen_string_literal: true

# vacant_information_with_past.rb
class VacantInformationWithPast < VacantInformation
  attr_reader :past_number

  def initialize(id:, past_number:, context: nil)
    @past_number = past_number
    super(id: id, context: context)
  end

  def exceed_the_threshold?
    diff_number < -70 || diff_number > 2
  end

  def scraping_word
    ScrapingWord.new(id: id)
  end

  def display_diff_number
    if diff_number.positive?
      "枠が #{diff_number.abs} 増えました。"
    else
      "枠が #{diff_number.abs} 減りました。"
    end
  end

  private

  def diff_number
    number - past_number
  end
end
