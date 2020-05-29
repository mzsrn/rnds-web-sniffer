class ResourceSettingsController < ApplicationController
  before_action :set_resource_setting, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    @resource_settings = current_user&.resource_settings
  end

  def show
  end

  def new
    @resource_setting = ResourceSetting.new
  end

  def edit
  end

  def create
    @resource_setting = ResourceSetting.new(resource_setting_params)

    respond_to do |format|
      if @resource_setting.save
        format.html { redirect_to @resource_setting, notice: 'Resource setting was successfully created.' }
        format.json { render :show, status: :created, location: @resource_setting }
      else
        format.html { render :new }
        format.json { render json: @resource_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @resource_setting.update(resource_setting_params)
        format.html { redirect_to @resource_setting, notice: 'Resource setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @resource_setting }
      else
        format.html { render :edit }
        format.json { render json: @resource_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @resource_setting.destroy
    respond_to do |format|
      format.html { redirect_to resource_settings_url, notice: 'Resource setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_resource_setting
    @resource_setting = ResourceSetting.find(params[:id])
  end

  def resource_setting_params
    params.require(:resource_setting).permit(:login, :type)
  end
  
end
