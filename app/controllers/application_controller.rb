class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :http_basic_authenticate
  #after_action :verify_authorized

  def http_basic_authenticate
    authenticate_or_request_with_http_basic do |name, password|
      name == WitesyConfiguration::Auth::USERNAME && password == WitesyConfiguration::Auth::PASSWORD
    end
  end

  def check_user_status
      if !session[:user_id]
        flash[:danger] = "You must be logged in to access this section"
        redirect_to :action=>"index", :controller=>"welcome"
      end

      if !$current_user
        $current_user = User.find(session[:user_id]) if session[:user_id]
      if $current_user
        if $current_user.confirmed_email
          @confirmed = true
        else
          @confirmed = false
          flash[:warning] = 'User not confirmed'
        end
      end
    end
  end

  # Manage pundit permission and authorization
  def pundit_user
    current_user = $current_user
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
    def user_not_authorized
      flash[:warning] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
end
