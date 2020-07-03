class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to authenticated_root_path, notice: 'Forbidden action'
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    Rails.logger.error "[ActiveRecord::RecordNotFound] #{e.backtrace.first(10).join("\n")}"
    respond_to do |f|
      f.html do
        redirect_to authenticated_root_path, notice: 'Страницы, к которой Вы обращаетесь, не существует!'
      end
      f.json do
        render json: {}, :status => 404
      end
    end
  end

  rescue_from ArgumentError do |e|
    render json: {error: e.message}, :status => 400
  end

  rescue_from ::ExecuteError do |e|
    render json: { error: e.message}, :status => 400  
  end

  protected

  def render_error msg, status=400
    error = if msg.respond_to? :to_hash
      mgs
    else
      { error: msg }
    end
    render json: error, status: status
  end

end
