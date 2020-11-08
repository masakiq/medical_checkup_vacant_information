# frozen_string_literal: true

class VacantTest < Test::Unit::TestCase
  def test_number_when_context_is_empty
    vacant = Vacant.new(id: 'ookubo_basic_pm')

    assert_equal(vacant.number, 0)
  end

  def test_number_when_context_is_nil
    vacant = Vacant.new(id: 'ookubo_basic_pm', context: nil)

    assert_equal(vacant.number, 0)
  end

  def test_number_when_context_is_blank
    vacant = Vacant.new(id: 'ookubo_basic_pm', context: '')

    assert_equal(vacant.number, 0)
  end

  def test_number_when_context_is_random
    vacant = Vacant.new(id: 'ookubo_basic_pm', context: 'あああ')

    assert_equal(vacant.number, 0)
  end

  def test_number_when_context_is_valid_1
    vacant = Vacant.new(
      id: 'ookubo_basic_pm',
      context: '現在のところ空きがありません。'
    )

    assert_equal(vacant.number, 0)
  end

  def test_number_when_context_is_valid_2
    vacant = Vacant.new(
      id: 'ookubo_basic_pm',
      context: '最短 10/01 より20個の枠があります。'
    )

    assert_equal(vacant.number, 20)
  end

  def test_initialize_when_id_is_invalid
    e = assert_raises StandardError do
      Vacant.new(id: 'invalid')
    end

    assert_equal 'invalid id : invalid', e.message
  end
end
