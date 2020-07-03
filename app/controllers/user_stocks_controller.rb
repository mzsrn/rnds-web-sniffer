class UserStocksController < ApplicationController

  class NotEnoughBalance < RuntimeError; end

  # rescue_from NotEnoughBalance do
  #   render_error
  # end

  def create
    token = params[:token]
    figi = params[:figi]
    amount = params[:amount]
    account = params[:account]
    api_client = ApiAdapter::Tinkoff.new(token)
    if api_client.make_market_order(figi, amount, account)
      if account.present?
        redirect_to account.portfolio
      else
        redirect_to portfolios_path
      end
    end
  end


end
