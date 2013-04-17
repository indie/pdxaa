class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
	
  def authorize
  	redirect_to signin_url, alert: "Not authorized.  Please sign in." if current_user.nil?
  end

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end

end

