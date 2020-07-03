class ApiAdapter::Tinkoff < ApiAdapter::Base

  # Адаптер реализует логику и последовательность выполнения запросов в соответствие с брокером,
  # а также обязывает реализовывать интерфейс определенный в ApiAdapter::Base
  
  attr_reader :sender

  DEFAULT_HEADERS = {
    headers: {
      "Content-Type" => "application/json"
    }
  }

  def initialize token
    @sender = ApiAdapter::Tinkoff::Sender.new(token)
  end

  def get_accounts
    response = @sender.get_accounts
    return response["payload"]["accounts"].pluck("brokerAccountId") if @sender.errors.empty?
    raise ApiError, @sender.errors.flat_map(&:values).join(', ')
  end

  def get_portfolio account_id=nil
    account_id = get_accounts.first if account_id.nil?
    raise ApiError, "Не найден брокерский счет" if account_id.nil?
    @sender.params["brokerAccountId"] = account_id
    response = @sender.get_portfolio
    return response["payload"] if @sender.errors.empty?
    raise ApiError, @sender.errors.flat_map(&:values).join(', ')
  end

  def get_stocks
    @sender.get_stocks
  end

  def make_market_order(figi, lots, account=nil)
    selected_account = account || get_accounts[0]
    @sender.body = {
      lots: lots.to_i,
      operation: "Buy"
    }
    @sender.params = {
      figi: figi,
      brokerAccountId: selected_account
    }
    res = @sender.make_market_order
    code = res.response.code
    body = JSON.parse res.response.body
    raise NotEnoughBalance.new("Недостаточно средств") if body["status"] == "Error"
    raise RuntimeError if code.to_i >= 400
    return true
  end

end