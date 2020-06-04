class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def create
    ActionCable.server.broadcast("bobik:#{current_user.id}", content: 'Start connecting from controller')
    CallBobikJob.perform_later(current_user.id, params['resource_setting_id'], params["login"], params["password"])
    render json: {}, status: :ok 
  end

  private

  def set_portfolio
    @resource = ResourceSetting.find_by(id: params[:id])
    @portfolio = @resource&.portfolio
  end

end
