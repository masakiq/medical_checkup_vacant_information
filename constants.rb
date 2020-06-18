# frozen_string_literal: true

# constants.rb
module Constants
  TARGET_WORDS = {
    ookubo_basic_pm: '大久保　基本健診【午後】',
    ookubo_one_day_medical_checkup_gastroscope_am: '大久保　1日人間ドック（胃内視鏡）【午前】',
    ookubo_one_day_medical_checkup_x_ray_of_stomach_am: '大久保　1日人間ドック（胃部X線）【午前】',
    ookubo_one_day_medical_checkup_x_ray_of_stomach_pm: '大久保　1日人間ドック（胃部X線）【午後】',
    sanno_basic_pm: '山王　基本健診【午後】',
    sanno_one_day_medical_checkup_gastroscope_am: '山王　1日人間ドック（胃内視鏡）【午前】',
    sanno_one_day_medical_checkup_x_ray_of_stomach_am: '山王　1日人間ドック（胃部X線）【午前】',
    sanno_one_day_medical_checkup_x_ray_of_stomach_pm: '山王　1日人間ドック（胃部X線）【午後】'
  }.freeze

  VACANT_INFO_TABLE =
    if ENV['development']
      'medical_checkup_vacant_information_development'
    else
      'medical_checkup_vacant_information'
    end
end
