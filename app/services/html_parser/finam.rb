class HtmlParser::Finam < HtmlParser::Base

  def get_table_head
    strategy = I18n.t('table')
    navigation_element = strategy.dig(:head, :path, :navigation_element)
    navigation_attributes = strategy.dig(:head, :path, :navigation_attributes)
    values = strategy.dig(:head, :values)
    table_head = {}.tap do |head|
      values.keys.each do |key|
        element = @document.search("#{navigation_element}[#{navigation_attributes}='#{key}']")
        head[key] = element.last['title'] if element.count == 1
      end
    end
  end

  def get_table_body
    strategy = I18n.t('table')[:body]
    body = @document.css(strategy[:css])
    rows = body.css(strategy[:rows][:css])
    cells = strategy[:rows][:cells]
    portfolio_body = []
    rows.each_with_index do |row, idx|
      position_row = {}.tap do |pr|
        cells.each do |cell|
          pr[cell[:name]] = if cell[:value] == 'title'
            row.css(cell[:css]).last['title']
          else
            row.css(cell[:css]).last&.inner_html
          end
        end
      end
      portfolio_body << position_row
    end
    portfolio_body
  end

end