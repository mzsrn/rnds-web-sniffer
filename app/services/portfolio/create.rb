class Portfolio::Create < ActiveInteractionBase

  object :user, class: User
  object :params, class: ActionController::Parameters

  def execute
    # TODO add_error(:base, "Invalid broker") unless %w(finam tinkoff).include? broker
    # TODO separate to classes
    if broker == "tinkoff"
      @collar = Collar::Tinkoff.new(user, credentials)
      @bobik = Bobik::Tinkoff.new(@collar)
      user_account = setup_account_info
      return unless portfolio_data = @bobik.get_portfolio(user_account.number)
      create_portfolio portfolio_data, user_account
    else
      CallBobikJob.perform_now(user.id, credentials)
      return { status: "ok" }
    end
  rescue StandardError => e
    errors.add(:base, e.message) 
  end

  private

  def broker
    params.require(:broker)
  end

  def credentials
    params.require(:credentials)
  end

  def account
    params[:account].presence
  end

  def setup_account_info
    if accounts = @bobik.get_accounts
      create_account(account || accounts[0])
    end
  end

  def create_account account
    user_broker = create_broker
    user_account = Account.find_or_initialize_by(user: @collar.user, number: account, broker: user_broker)
    return user_account if user_account.save
  end
  
  def create_broker
    user_broker = Broker.find_or_initialize_by(user: @collar.user, name: broker)
    return user_broker if user_broker.save
  end

  def create_portfolio portfolio_data, account
    user_portfolio = Portfolio.find_or_initialize_by(user_id: @collar.user.id, broker_id: account.broker.id, account_id: account.id)
    user_portfolio.data = portfolio_data
    return user_portfolio if user_portfolio.save
  end

end