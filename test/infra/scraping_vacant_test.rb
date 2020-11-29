# frozen_string_literal: true

class ScrapingVacantTest < Test::Unit::TestCase
  class DummyFetchHtml < AbstractFetchHtml
    KENPO_URL = './test/dummy_html/kenpo.html'

    def self.execute
      content = File.open(KENPO_URL).read
      content.split("\n").map(&:strip)
    end
  end

  def test_execute
    html_elements = DummyFetchHtml.execute
    vacants = ScrapingVacant.execute(html_elements)

    assert_equal(vacants.count, 8)
    assert_equal(vacants.map(&:class).map(&:to_s).all?('Vacant'), true)
    nums = [0, 28, 6, 0, 0, 0, 2, 0]
    vacants.each_with_index do |v, i|
      assert_equal(v.number, nums[i])
    end
  end
end
