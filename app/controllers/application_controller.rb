class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!

  def render_turbo_flash
    turbo_stream.update('flash', partial: 'shared/flash')
  end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end
end
