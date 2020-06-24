class Bobik::Tinkoff < Bobik::Base

  def initialize collar
    @sender = ApiAdapter::Tinkoff.new(collar.token)
    super(collar)
  end

  def get_accounts
    @sender.get_accounts
  rescue StandardError => e
    byebug
  end

  def get_portfolio
    @sender.get_portfolio
  rescue StandardError => e
    byebug
  end

end