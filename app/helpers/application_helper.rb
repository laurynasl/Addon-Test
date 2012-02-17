module ApplicationHelper

  def user_ip_address
    request.env['HTTP_X_FORWARDED_FOR'] || request.env['REMOTE_ADDR']
  end
end
