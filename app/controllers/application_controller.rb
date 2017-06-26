class ApplicationController < ActionController::Base
  include Monban::ControllerHelpers
  protect_from_forgery with: :exception

  private

  def current_user
    super || Guest.new
  end
end
