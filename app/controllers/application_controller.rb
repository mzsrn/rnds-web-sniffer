class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    format.json { render nothing: true, status: :not_found }
    format.html { redirect_to main_app.root_url, notice: exception.message, status: :not_found }
  end

end
