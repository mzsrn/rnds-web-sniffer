class ApiAdapter::Tinkoff::Sender
  
  include HTTParty
  
  attr_accessor :params, :body
  attr_reader   :errors
  
  base_uri 'https://api-invest.tinkoff.ru/openapi/sandbox'
  
  def initialize token, params = {}, body = {}
    @token, @params, @body = token, params, body
    @errors = []
  end

  def get_accounts
    response = request(:get, '/user/accounts')
    if response.code < 400
      response.parsed_response
    else
      add_error(response)
      []
    end
  rescue HTTParty::Error => e
    add_error e
  end

  def get_portfolio
    response = request(:get, '/portfolio')
    if response.code < 400
      response.parsed_response
    else
      add_error(response)
      {}
    end
  rescue HTTParty::Error => e
    add_error e
  end

  def get_stocks
    response = request(:get, '/market/portfolio')
    response.parsed_response
  end

  def make_market_order
    request(:post, '/orders/market-order')
  rescue HTTParty::Error => e
    add_error e
  end


  private

  def request http_method, query
    self.class.send(http_method, query, opts)
  end

  def opts
    {
      query: @params,
      body: @body.to_json,
      headers: {
        "Authorization" => "Bearer #{@token}",
        "Content-Type" => "application/json"
      }
    }
  end

  def add_error error
    if error.respond_to?(:code)
      error_description = error_description error
    else
      Rails.logger.error 'SenderError'
      Rails.logger.error error.to_s
      Rails.logger.error error.backtrace.last(10).join("\n")
      error_description = { "#{error.message}" => "Произошла ошибка, повторите запрос позже" }
    end
    @errors << error_description
  end

  def error_description error
    case error.code
    when 401
      { unauthorized: "Указан неправильный токен" }
    when 404
      { not_found: "Указанный ресурс не найден" }
    when 500
      { not_found: error.parsed_response["payload"]["message"] }
    else
      { unknown: "Произошла ошибка, повторите запрос позже" }
    end
  end

end