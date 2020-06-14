# frozen_string_literal: true

# constants.rb
module Constants
  TARGET_WORDS = {
    ookubo_basic_pm: '大久保　基本健診【午後】',
    ookubo_specified_am: '大久保　健保指定ドック【午前】',
    ookubo_specified_pm: '大久保　健保指定ドック【午後】',
    sanno_basic_pm: '山王　基本健診【午後】',
    sanno_specified_am: '山王　健保指定ドック【午前】',
    sanno_specified_pm: '山王　健保指定ドック【午後】'
  }.freeze

  VACANT_INFO_TABLE =
    if ENV['development']
      'medical_checkup_vacant_information_development'
    else
      'medical_checkup_vacant_information'
    end
end
