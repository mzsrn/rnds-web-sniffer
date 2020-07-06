class Portfolio::Update < ActiveInteractionBase

  object :user, class: User
  string :token
  string :account

  def execute
    # TODO For all brokers (finam)
    @collar = Collar::Tinkoff.new(user, {token: token})
    @bobik = Bobik::Tinkoff.new(@collar)
    user_account = Account.find_by(number: account)
    portfolio_data = @bobik.get_portfolio(user_account.number)
    user_portfolio = Portfolio.find_or_initialize_by(account: user_account, user: user)
    user_portfolio.update(data: portfolio_data)
    return user_portfolio
  rescue StandardError => e
    errors.add(:base, e.message) 
  end

end