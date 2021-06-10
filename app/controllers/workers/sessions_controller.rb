class Workers::SessionsController < Devise::SessionsController
  before_action :check_admin!, only: %i[create]

  def check_admin!
    domain = Company.get_domain(params[:worker][:email])
    redirect_to new_admin_session_path if domain == 'paynow'
  end
end
