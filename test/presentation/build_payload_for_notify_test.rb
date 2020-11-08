# frozen_string_literal: true

class BuildPayloadForNotifyTest < Test::Unit::TestCase
  def test_execute_1 # rubocop:disable Metrics/MethodLength
    vacants = ScrapingText::LIST.keys.map do |text|
      VacantWithPast.new(
        id: text,
        past_number: 5,
        context: '最短10/01より10個の枠があります。'
      )
    end
    payload = BuildPayloadForNotify.new.execute(vacants)

    expected_payload = <<~PAYLOAD
      *空き情報が更新されました*

      ```
      大久保　基本健診【午後】
      最短10/01より10個の枠があります。
      枠が 5 増えました。
      ```
      ```
      大久保　1日人間ドック（胃内視鏡）【午前】
      最短10/01より10個の枠があります。
      枠が 5 増えました。
      ```
      ```
      大久保　1日人間ドック（胃部X線）【午前】
      最短10/01より10個の枠があります。
      枠が 5 増えました。
      ```
      ```
      大久保　1日人間ドック（胃部X線）【午後】
      最短10/01より10個の枠があります。
      枠が 5 増えました。
      ```
      ```
      山王　基本健診【午後】
      最短10/01より10個の枠があります。
      枠が 5 増えました。
      ```
      ```
      山王　1日人間ドック（胃内視鏡）【午前】
      最短10/01より10個の枠があります。
      枠が 5 増えました。
      ```
      ```
      山王　1日人間ドック（胃部X線）【午前】
      最短10/01より10個の枠があります。
      枠が 5 増えました。
      ```
      ```
      山王　1日人間ドック（胃部X線）【午後】
      最短10/01より10個の枠があります。
      枠が 5 増えました。
      ```
    PAYLOAD

    assert_equal(payload, expected_payload)
  end

  def test_execute_2
    payload = BuildPayloadForNotify.new.execute([])

    assert_equal(payload, nil)
  end
end
