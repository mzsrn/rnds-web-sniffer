class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: [:show, :edit, :update, :destroy]
  before_action :set_resource, only: :create
  authorize_resource

  def show
  end

  def create
    ActionCable.server.broadcast("bobik:#{current_user.id}", content: 'Start connecting from controller')
    CallBobikJob.perform_now(current_user.id, @resource, permitted_params )
  end

  private

  def permitted_params
    case @resource.type
    when 'finam'
      params.permit(:login, :password)
    when 'tinkoff'
      params.permit(:token)
    end
  end

  def set_portfolio
    @resource = ResourceSetting.find(params[:id])
    @portfolio = @resource&.portfolio
  end

  def set_resource
    @resource = ResourceSetting.find(params[:resource_setting_id])
  end

end
