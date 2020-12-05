# frozen_string_literal: true

class AllVacantsPayloadBuilderTest < Test::Unit::TestCase
  def test_execute_1 # rubocop:disable Metrics/MethodLength
    vacants = ScrapingText::LIST.keys.map do |text|
      Vacant.new(
        id: text,
        context: '最短10/01より10個の枠があります。'
      )
    end

    increased_vacants = [
      VacantWithPast.new(
        id: ScrapingText::LIST.keys.first,
        past_number: 5,
        context: '最短10/01より10個の枠があります。'
      )
    ]

    become_to_zero_vacants = [
      VacantWithPast.new(
        id: ScrapingText::LIST.keys.first,
        past_number: 5,
        context: '最短10/01より10個の枠があります。'
      )
    ]

    payload = AllVacantsPayloadBuilder.new.execute(vacants, increased_vacants, become_to_zero_vacants)

    expected_payload = <<~PAYLOAD
      *全体の空き状況*

      ```
      大久保　基本健診【午後】　　　　　　　　　　　　　最短10/01より10個の枠があります。
      大久保　１日人間ドック（胃内視鏡）【午前】　　　　最短10/01より10個の枠があります。
      大久保　１日人間ドック（胃部Ｘ線）【午前】　　　　最短10/01より10個の枠があります。
      大久保　１日人間ドック（胃部Ｘ線）【午後】　　　　最短10/01より10個の枠があります。
      山王　基本健診【午後】　　　　　　　　　　　　　　最短10/01より10個の枠があります。
      山王　１日人間ドック（胃内視鏡）【午前】　　　　　最短10/01より10個の枠があります。
      山王　１日人間ドック（胃部Ｘ線）【午前】　　　　　最短10/01より10個の枠があります。
      山王　１日人間ドック（胃部Ｘ線）【午後】　　　　　最短10/01より10個の枠があります。
      ```
    PAYLOAD

    assert_equal(payload, expected_payload)
  end

  def test_execute_2
    vacants = ScrapingText::LIST.keys.map do |text|
      Vacant.new(
        id: text,
        context: '最短10/01より10個の枠があります。'
      )
    end

    increased_vacants = []

    become_to_zero_vacants = []

    payload = AllVacantsPayloadBuilder.new.execute(vacants, increased_vacants, become_to_zero_vacants)

    assert_equal(payload, nil)
  end

  def test_execute_3
    payload = AllVacantsPayloadBuilder.new.execute([], [], [])

    assert_equal(payload, nil)
  end
end
