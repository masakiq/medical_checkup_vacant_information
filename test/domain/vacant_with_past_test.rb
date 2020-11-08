# frozen_string_literal: true

class VacantWithPastTest < Test::Unit::TestCase
  def test_reached_the_value_to_be_notified_1
    past_vacant = VacantWithPast.new(
      id: 'ookubo_basic_pm',
      context: '最短 10/01 より13個の枠があります。',
      past_number: 10
    )

    assert_equal(past_vacant.reached_the_value_to_be_notified?, true)
  end

  def test_reached_the_value_to_be_notified_2
    past_vacant = VacantWithPast.new(
      id: 'ookubo_basic_pm',
      context: '最短 10/01 より12個の枠があります。',
      past_number: 10
    )

    assert_equal(past_vacant.reached_the_value_to_be_notified?, false)
  end

  def test_reached_the_value_to_be_notified_3
    past_vacant = VacantWithPast.new(
      id: 'ookubo_basic_pm',
      context: '最短 10/01 より30個の枠があります。',
      past_number: 100
    )

    assert_equal(past_vacant.reached_the_value_to_be_notified?, false)
  end

  def test_reached_the_value_to_be_notified_4
    past_vacant = VacantWithPast.new(
      id: 'ookubo_basic_pm',
      context: '最短 10/01 より29個の枠があります。',
      past_number: 100
    )

    assert_equal(past_vacant.reached_the_value_to_be_notified?, true)
  end

  def test_reached_the_value_to_be_notified_5
    past_vacant = VacantWithPast.new(
      id: 'ookubo_basic_pm',
      context: '最短 10/01 より0個の枠があります。',
      past_number: 2
    )

    assert_equal(past_vacant.reached_the_value_to_be_notified?, true)
  end

  def test_reached_the_value_to_be_notified_6
    past_vacant = VacantWithPast.new(
      id: 'ookubo_basic_pm',
      context: '最短 10/01 より1個の枠があります。',
      past_number: 2
    )

    assert_equal(past_vacant.reached_the_value_to_be_notified?, false)
  end

  def test_display_diff_number_1
    past_vacant = VacantWithPast.new(
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
    past_vacant = VacantWithPast.new(
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
