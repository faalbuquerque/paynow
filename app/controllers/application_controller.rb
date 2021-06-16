class ApplicationController < ActionController::Base
  helper_method :authenticate_worker_admin!

  def authenticate_worker_admin!
    authenticate_worker!
    unless current_worker.admin?
      return redirect_to root_path, alert: t('unauthorized')
    end
  end
end
