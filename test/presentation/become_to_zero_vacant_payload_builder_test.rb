# frozen_string_literal: true

class BecomeToZeroVacantPayloadBuilderTest < Test::Unit::TestCase
  def test_execute_1 # rubocop:disable Metrics/MethodLength
    vacants = ScrapingText::LIST.keys.map do |text|
      VacantWithPast.new(
        id: text,
        past_number: 10,
        context: '現在のところ空きがありません。'
      )
    end
    payload = BecomeToZeroVacantPayloadBuilder.new.execute(vacants)

    expected_payload = <<~PAYLOAD
      *空きが無くなりました*

      ```
      大久保　基本健診【午後】
      現在のところ空きがありません。
      ```
      ```
      大久保　1日人間ドック（胃内視鏡）【午前】
      現在のところ空きがありません。
      ```
      ```
      大久保　1日人間ドック（胃部X線）【午前】
      現在のところ空きがありません。
      ```
      ```
      大久保　1日人間ドック（胃部X線）【午後】
      現在のところ空きがありません。
      ```
      ```
      山王　基本健診【午後】
      現在のところ空きがありません。
      ```
      ```
      山王　1日人間ドック（胃内視鏡）【午前】
      現在のところ空きがありません。
      ```
      ```
      山王　1日人間ドック（胃部X線）【午前】
      現在のところ空きがありません。
      ```
      ```
      山王　1日人間ドック（胃部X線）【午後】
      現在のところ空きがありません。
      ```
    PAYLOAD

    assert_equal(payload, expected_payload)
  end

  def test_execute_2
    payload = BecomeToZeroVacantPayloadBuilder.new.execute([])

    assert_equal(payload, nil)
  end
end
