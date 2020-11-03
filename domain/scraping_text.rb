# frozen_string_literal: true

# ScrapingText
class ScrapingText
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

  attr_reader :body

  def initialize(id:)
    @body = LIST[id.to_sym]
    validate_body!
  end

  private

  def validate_body!
    raise StandardError, 'invalid body' if body.nil?
  end
end
