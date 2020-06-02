class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def create
    ActionCable.server.broadcast("bobik:#{current_user.id}", content: 'Start connecting from controller')
    # Bobik.new(current_user.id, params["login"], params["password"])
    CallBobikJob.perform_later(current_user.id, params["login"], params["password"])
    # byebug
  end

  private

  def set_portfolio
    @resource = ResourceSetting.find_by(id: params[:id])
    @portfolio = @resource&.portfolio
  end

end
