class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def authenticate_user
    if current_user == nil
      redirect_to new_session_path,notice:"ログインが必要です"
    end
  end

  class Forbidden < ActionController::ActionControllerError
  end

  rescue_from Forbidden, with: :rescue403

  private
    def rescue403(e)
      @exception = e
      render template: "layouts/forbidden",status: 403
    end
end
