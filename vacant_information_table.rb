# frozen_string_literal: true

VACANT_INFORMATION_TABLE =
  if ENV['development']
    'medical_checkup_vacant_information_development'
  elsif ENV['staging']
    'medical_checkup_vacant_information_staging'
  else
    'medical_checkup_vacant_information'
  end
