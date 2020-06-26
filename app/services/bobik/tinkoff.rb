class Bobik::Tinkoff < Bobik::Base

  def initialize collar
    @sender = ApiAdapter::Tinkoff.new(collar.token)
    super(collar)
  end

  def get_accounts
    @sender.get_accounts
  end

  def get_portfolio account=nil
    res = @sender.get_portfolio account
  end

end