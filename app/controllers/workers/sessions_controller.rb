class Workers::SessionsController < Devise::SessionsController
  before_action :check_admin!, only: %i[create]

  def check_admin!
    domain = Company.get_domain(params[:worker][:email])
    signin_or_redirect_admin(params) if domain == 'paynow'
  end

  def signin_or_redirect_admin(parameters)
    email = parameters[:worker][:email]
    password = parameters[:worker][:password]

    if Admin.exists?(email: email)
      admin = Admin.find_by(email: email)
      return sign_in_and_redirect(admin) if admin.correct_password?(password)

      redirect_to new_admin_session_path, alert: 'Email ou senha inválida.'
    end
  end
end
