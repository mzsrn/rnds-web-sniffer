class Bobik

  def initialize user_id, login, password
    @user_id, @login, @password = user_id, login, password
    fetch_from 'esia'
  end

  private

  def fetch_from source
    profile = Selenium::WebDriver::Chrome::Profile.new()
    profile.add_extension("/home/marat/projects/rnds-sniffer.crx")
    @driver = Selenium::WebDriver.for :chrome, profile: profile
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
    @driver.get('https://trading.finam.ru/')
    ActionCable.server.broadcast("bobik:#{@user_id}", content: 'Connected to FINAM')
    find_wait_and_click('/html/body/div[1]/div/div[2]/div[2]/div[1]/div/ul/div[3]')
    sleep(2)
    fill_in('/html/body/div[1]/div/div[2]/div[2]/div[1]/div/div[1]/form/div[1]/div/input', @login)
    fill_in('/html/body/div[1]/div/div[2]/div[2]/div[1]/div/div[1]/form/div[2]/div[1]/input', @password)
    find_and_click('/html/body/div[1]/div/div[2]/div[2]/div[1]/div/div[1]/form/div[3]/button')
    sleep(4)
    doc = Nokogiri::HTML(@driver.page_source)

    # file = File.open('/home/marat/projects/rnds-web-sniffer/tmp/finam.html', 'r')
    # doc = Nokogiri::HTML(file)
    parser = HtmlParser::Finam.new(doc)
    kek = parser.get_table_body
    ActionCable.server.broadcast("bobik:#{@user_id}", kek)
    parser.get_table_body
  ensure
    @driver.quit
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