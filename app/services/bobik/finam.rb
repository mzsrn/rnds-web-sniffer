class Bobik::Finam < Bobik::Base

  def initialize collar
    super(collar)
    @login = collar.login
    @password = collar.password
  end

  def fetch!
    # doc = get_actual_doc
    doc = get_local_doc
    parser = HtmlParser::Finam.new(doc)
    body = parser.get_table_body
    head = I18n.t('table')[:head]
    @user.portfolios.with_broker("finam").destroy_all
    Portfolio.create(user: @user, data: body, account: @login, broker: "finam")
    ActionCable.server.broadcast("bobik:#{@user.id}", result: {head: head, body: body})
  end

  private

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
    ActionCable.server.broadcast("bobik:#{@user.id}", content: 'Connected to FINAM')
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