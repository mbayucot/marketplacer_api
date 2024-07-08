class ApplicationController < ActionController::API
  include ExceptionHandler
  before_action :authenticate_user!
end
