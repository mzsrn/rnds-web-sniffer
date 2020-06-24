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

end