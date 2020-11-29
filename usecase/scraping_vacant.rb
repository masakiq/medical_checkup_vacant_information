# frozen_string_literal: true

# class ScrapingVacant
class ScrapingVacant
  def execute(html_elements)
    table_elements = extract_table_elements(html_elements)
    target_indexies = extract_target_indexes(table_elements)
    vacant_elements = extract_vacant_elements(table_elements, target_indexies)
    map_vacants(vacant_elements)
  end

  private

  def extract_table_elements(html_elements)
    html_elements.select do |e|
      e.match(/\A<th.+?\z/) || e.match(/\A<td.+?\z/)
    end
  end

  def extract_target_indexes(table_elements)
    indexes = []
    table_elements.each_with_index do |elements, index|
      id = vacant_id_if_include_target_word(elements)
      next unless id

      indexes << {
        id: id,
        index: index + 1
      }
    end
    indexes
  end

  def vacant_id_if_include_target_word(elements)
    ScrapingText::LIST.each do |id, value|
      return id if elements.include?(value)
    end
    false
  end

  def extract_vacant_elements(table_elements, target_indexies)
    vacant_elements = []
    target_indexies.each do |index|
      vacant_elements << {
        id: index[:id],
        body: table_elements[index[:index]]
      }
    end
    vacant_elements
  end

  def map_vacants(vacant_elements)
    vacants = []
    vacant_elements.each do |e|
      context = extract_target_text(e[:body])
      vacants << Vacant.new(id: e[:id], context: context)
    end
    vacants
  end

  def extract_target_text(info)
    context = info.match(%r{\A<td.+?>(?<context>.+?)</td>\z})[:context]
    context.match(/\A.+?(?<target_text>[最短|現在].+?)\z/)[:target_text]
  end
end
