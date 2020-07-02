class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def new
    @portfolio = Portfolio.new
  end

  def index
    @portfolios = current_user.portfolios
  end

  def show
  end

  def create
    # ActionCable.server.broadcast("bobik:#{current_user.id}", content: 'Start connecting from controller')
    set_info
    res = Portfolio::Create.run(user: current_user, params: required_params)
    byebug
    portfolio = Portfolio.find_or_initialize_by(user_id: current_user.id, account: account)
    if portfolio.persisted?
      portfolio.update(data: portfolio_data, account: account)
    else
      portfolio.data = portfolio_data
      portfolio.save
    end
    render json: portfolio, status: 201
  end

  def update
    set_info
    if @broker == "finam"
      CallBobikJob.perform_now(current_user.id, @credentials)
    else
      collar = Collar::Tinkoff.new(current_user, @credentials)
      bobik = Bobik::Tinkoff.new(collar)
      account = bobik.get_accounts[0]
      portfolio = Portfolio.find_or_initialize_by(user_id: current_user.id, account: account)
      portfolio_data = bobik.get_portfolio(account)
      if @portfolio.update(data: portfolio_data, account: account)
        render json: @portfolio, status: 201
      end
    end
  end

  def destroy
    Portfolio.find(params[:id]).destroy
    redirect_to portfolios_path
  end 

  private

  def required_params
    params.require(:params)
  end

  def set_info
    data = params.permit!.to_h["params"]
    @broker = data.delete("broker")
    @credentials = data.delete("credentials")
  end

  def set_portfolio
    @portfolio = Portfolio.find(params[:id])
  end

end
