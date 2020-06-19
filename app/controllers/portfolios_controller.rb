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
    ActionCable.server.broadcast("bobik:#{current_user.id}", content: 'Start connecting from controller')
    set_info
    if @broker == "finam"
      collar = Collar::Finam.new(current_user, @credentials)
      CallBobikJob.perform_later(collar)
    else
      collar = Collar::Tinkoff.new(current_user, @credentials)
      portfolio_data = Bobik::Tinkoff.new(collar).fetch_portfolio!
      if portfolio = Portfolio.create(data: portfolio_data, user: current_user, broker: @broker)
        render json: portfolio, status: 201
      end
    end
  end

  def update
    set_info
    if @broker == "finam"
      collar = Collar::Finam.new(current_user, @credentials)
      CallBobikJob.perform_later(collar)
    else
      collar = Collar::Tinkoff.new(current_user, @credentials)
      portfolio_data = Bobik::Tinkoff.new(collar).fetch_portfolio!
      if @portfolio.update(data: portfolio_data)
        render json: @portfolio, status: 201
      end
    end
  end

  private

  def set_info
    data = params.permit!.to_h["params"]
    @broker = data.delete("broker")
    @credentials = data.delete("credentials")
  end

  def set_portfolio
    @portfolio = Portfolio.find(params[:id])
  end

end
