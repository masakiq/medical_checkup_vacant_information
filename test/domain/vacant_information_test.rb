# frozen_string_literal: true

class VacantInformationTest < Test::Unit::TestCase
  def test_number_when_context_is_empty
    vacant = VacantInformation.new(id: 'ookubo_basic_pm')

    assert_equal(vacant.number, 0)
  end

  def test_number_when_context_is_nil
    vacant = VacantInformation.new(id: 'ookubo_basic_pm', context: nil)

    assert_equal(vacant.number, 0)
  end

  def test_number_when_context_is_blank
    vacant = VacantInformation.new(id: 'ookubo_basic_pm', context: '')

    assert_equal(vacant.number, 0)
  end

  def test_number_when_context_is_random
    vacant = VacantInformation.new(id: 'ookubo_basic_pm', context: 'あああ')

    assert_equal(vacant.number, 0)
  end

  def test_number_when_context_is_valid_1
    vacant = VacantInformation.new(
      id: 'ookubo_basic_pm',
      context: '現在のところ空きがありません。'
    )

    assert_equal(vacant.number, 0)
  end

  def test_number_when_context_is_valid_2
    vacant = VacantInformation.new(
      id: 'ookubo_basic_pm',
      context: '最短 10/01 より20個の枠があります。'
    )

    assert_equal(vacant.number, 20)
  end

  def test_initialize_when_id_is_invalid
    e = assert_raises StandardError do
      VacantInformation.new(id: 'invalid')
    end

    assert_equal 'invalid id', e.message
  end
end
