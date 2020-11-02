# frozen_string_literal: true

# scraping_word.rb
class ScrapingWord
  LIST = {
    ookubo_basic_pm: '大久保　基本健診【午後】',
    ookubo_one_day_medical_checkup_gastroscope_am: '大久保　1日人間ドック（胃内視鏡）【午前】',
    ookubo_one_day_medical_checkup_x_ray_of_stomach_am: '大久保　1日人間ドック（胃部X線）【午前】',
    ookubo_one_day_medical_checkup_x_ray_of_stomach_pm: '大久保　1日人間ドック（胃部X線）【午後】',
    sanno_basic_pm: '山王　基本健診【午後】',
    sanno_one_day_medical_checkup_gastroscope_am: '山王　1日人間ドック（胃内視鏡）【午前】',
    sanno_one_day_medical_checkup_x_ray_of_stomach_am: '山王　1日人間ドック（胃部X線）【午前】',
    sanno_one_day_medical_checkup_x_ray_of_stomach_pm: '山王　1日人間ドック（胃部X線）【午後】'
  }.freeze

  def initialize(id:)
    @target_word = LIST[id.to_sym]
    validate_target_word!
  end

  attr_reader :target_word

  private

  def validate_target_word!
    raise StandardError, 'invalid target_word' if target_word.nil?
  end
end
