# frozen_string_literal: true

class VacantInformationWithPastTest < Test::Unit::TestCase
  def test_exceed_the_threshold_1
    past_vacant = VacantInformationWithPast.new(
      id: 'ookubo_basic_pm',
      context: '最短 10/01 より13個の枠があります。',
      past_number: 10
    )

    assert_equal(past_vacant.exceed_the_threshold?, true)
  end

  def test_exceed_the_threshold_2
    past_vacant = VacantInformationWithPast.new(
      id: 'ookubo_basic_pm',
      context: '最短 10/01 より12個の枠があります。',
      past_number: 10
    )

    assert_equal(past_vacant.exceed_the_threshold?, false)
  end

  def test_exceed_the_threshold_3
    past_vacant = VacantInformationWithPast.new(
      id: 'ookubo_basic_pm',
      context: '最短 10/01 より30個の枠があります。',
      past_number: 100
    )

    assert_equal(past_vacant.exceed_the_threshold?, false)
  end

  def test_exceed_the_threshold_4
    past_vacant = VacantInformationWithPast.new(
      id: 'ookubo_basic_pm',
      context: '最短 10/01 より29個の枠があります。',
      past_number: 100
    )

    assert_equal(past_vacant.exceed_the_threshold?, true)
  end

  def test_display_diff_number_1
    past_vacant = VacantInformationWithPast.new(
      id: 'ookubo_basic_pm',
      context: '最短 10/01 より21個の枠があります。',
      past_number: 10
    )

    assert_equal(
      past_vacant.display_diff_number,
      '枠が 11 増えました。'
    )
  end

  def test_display_diff_number_2
    past_vacant = VacantInformationWithPast.new(
      id: 'ookubo_basic_pm',
      context: '最短 10/01 より29個の枠があります。',
      past_number: 100
    )

    assert_equal(
      past_vacant.display_diff_number,
      '枠が 71 減りました。'
    )
  end
end
