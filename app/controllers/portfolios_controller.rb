class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def create
    Bobik.new(params["login"], params["password"])
  end

  private

  def set_portfolio
    @resource = ResourceSetting.find_by(id: params[:id])
    @portfolio = @resource&.portfolio
  end

end
