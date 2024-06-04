class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def invalid_foreign_key
    flash[:alert] = 'Não é possível excluir este registro pois ele está sendo utilizado em outro lugar.'
    redirect_to request.referer
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
  end
end
