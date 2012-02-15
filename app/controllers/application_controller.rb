class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def user_ip_address
    request.env['HTTP_X_FORWARDED_FOR'] || request.env['REMOTE_ADDR']
  end
end
