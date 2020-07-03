class ApiAdapter::Base

  class ApiError < RuntimeError; end

  def get_accounts
    raise NotImplementedError
  end

  def get_portfolio
    raise NotImplementedError
  end

end