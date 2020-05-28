class Users::RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(permitted_params)
    super
  end

  private

  def permitted_params
    params.require(:user).permit([:email, :password, :password_confirmation])
  end

end

