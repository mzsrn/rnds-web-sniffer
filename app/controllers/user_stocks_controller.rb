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
    operation = params[:operation]
    api_client = ApiAdapter::Tinkoff.new(token)
    if api_client.make_market_order(figi, amount, account, operation)
      user_account = Account.find_by(number: account)
      res = Portfolio::Update.run!(user: current_user, token: token, account: account)
      render json: res
    else
      render_error "kek"
    end
  end


end
