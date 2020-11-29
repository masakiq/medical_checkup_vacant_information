# frozen_string_literal: true

class VacantWithPastTest < Test::Unit::TestCase
  def test_increased_1
    past_vacant = VacantWithPast.new(
      id: 'ookubo_basic_pm',
      context: '最短 10/01 より13個の枠があります。',
      past_number: 10
    )

    assert_equal(past_vacant.increased?, true)
  end

  def test_increased_2
    past_vacant = VacantWithPast.new(
      id: 'ookubo_basic_pm',
      context: '最短 10/01 より12個の枠があります。',
      past_number: 10
    )

    assert_equal(past_vacant.increased?, false)
  end

  def test_increased_3
    past_vacant = VacantWithPast.new(
      id: 'ookubo_basic_pm',
      context: '最短 10/01 より5個の枠があります。',
      past_number: 10
    )

    assert_equal(past_vacant.increased?, false)
  end

  def test_become_to_zero_1
    past_vacant = VacantWithPast.new(
      id: 'ookubo_basic_pm',
      context: '現在のところ空きがありません。',
      past_number: 5
    )

    assert_equal(past_vacant.became_to_zero?, true)
  end

  def test_become_to_zero_2
    past_vacant = VacantWithPast.new(
      id: 'ookubo_basic_pm',
      context: '現在のところ空きがありません。',
      past_number: 0
    )

    assert_equal(past_vacant.became_to_zero?, false)
  end

  def test_become_to_zero_3
    past_vacant = VacantWithPast.new(
      id: 'ookubo_basic_pm',
      context: '最短 10/01 より1個の枠があります。',
      past_number: 0
    )

    assert_equal(past_vacant.became_to_zero?, false)
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
