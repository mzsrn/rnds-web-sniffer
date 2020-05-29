class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    redirect_path = user_signed_in? ? authenticated_root_path : unauthenticated_root_path
    redirect_to redirect_path, notice: 'Forbidden action'
  end

end
