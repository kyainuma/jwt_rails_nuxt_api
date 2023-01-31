class ApplicationController < ActionController::API
  # Cookie
  include ActionController::Cookies
  # 認可
  include UserAuthenticateService
end
