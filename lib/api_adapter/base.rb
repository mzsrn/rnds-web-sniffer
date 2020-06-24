class ApiAdapter::Base

  class ApiError < StandardError; end

  def get_accounts
    raise NotImplementedError
  end

  def get_portfolio
    raise NotImplementedError
  end

end