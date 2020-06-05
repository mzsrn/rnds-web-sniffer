class Bobik

  def initialize user_id, resource_setting_id, login, password
    @user_id, @login, @password = user_id, login, password
    @portfolio = Portfolio.find_or_initialize_by(resource_setting_id: resource_setting_id)
    fetch_from 'finam'
  end

  private

  def fetch_from source
    doc = get_actual_doc
    # doc = get_local_doc
    parser = HtmlParser::Finam.new(doc)
    body = parser.get_table_body
    head = I18n.t('table')[:head]
    @portfolio.update(data: {body: body})
    ActionCable.server.broadcast("bobik:#{@user_id}", result: {head: head, body: body})
  end

  def get_actual_doc
    options_args = %w(
      --remote-debugging-port=9222
      --no-sandbox
      --allow-running-insecure-content
      --disable-gpu
      --window-size=1920,1080
      --start-maximised
      --no-sandbox
      --disable-dev-shm-usage
      --headless)
    options = Selenium::WebDriver::Chrome::Options.new(args: options_args)
    @driver = Selenium::WebDriver.for :chrome, options: options
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
    @driver.get('https://trading.finam.ru/')
    ActionCable.server.broadcast("bobik:#{@user_id}", content: 'Connected to FINAM')
    find_wait_and_click('/html/body/div[1]/div/div[2]/div[2]/div[1]/div/ul/div[3]')
    sleep(2)
    fill_in('/html/body/div[1]/div/div[2]/div[2]/div[1]/div/div[1]/form/div[1]/div/input', @login)
    fill_in('/html/body/div[1]/div/div[2]/div[2]/div[1]/div/div[1]/form/div[2]/div[1]/input', @password)
    find_and_click('/html/body/div[1]/div/div[2]/div[2]/div[1]/div/div[1]/form/div[3]/button')
    sleep(2)
    Nokogiri::HTML(@driver.page_source)
  ensure
    @driver.quit
  end

  def get_local_doc
    file = File.open('/home/marat/projects/rnds-web-sniffer/tmp/finam.html', 'r')
    Nokogiri::HTML(file)
  end

  def find_and_click field
    @driver.find_element(:xpath, field).click
  end
  
  def fill_in field, value
    element = @driver.find_element(:xpath, field)
    element.send_keys(value)
  end
  
  def find_wait_and_click field
    @wait.until { @driver.find_element(:xpath, field) }
    @driver.find_element(:xpath, field).click
  end

end