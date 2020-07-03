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
    res = Portfolio::Create.run(user: current_user, params: required_params)
    if res.errors.any?
      raise ExecuteError.new(res.errors.full_messages.join(', '))
    else
      @portfolio = res.result
    end
    respond_to do |format|
      format.html { redirect_to @portfolio }
      format.json { render :show, status: :ok}
    end
  end

  def update
  end

  def destroy
    Portfolio.find(params[:id]).destroy
    redirect_to portfolios_path
  end 

  private

  def required_params
    params.require(:params)
  end

  def set_portfolio
    @portfolio = Portfolio.find(params[:id])
  end

end
