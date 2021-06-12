class Workers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :find_or_generate_worker_dependencies, only: %i[create]

  def configure_permitted_parameters
    added_attrs = [:admin, :company_id, :email, :password,
                   :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def new
    @worker = Worker.new
  end

  private

  def find_or_generate_worker_dependencies
    @company = Company.find_by(domain: Company.get_domain(params[:worker][:email]))
    params[:worker][:admin] = false

    unless @company
      generate_company
      if (@company.valid? && @billing_address.has_all_attributes?)
        @company.persist_company(@billing_address)
        params[:worker][:admin] = true
      end
    end
    params[:worker][:company_id] = @company.id
  end

  def generate_company
    @company = Company.new(company_params)
    @billing_address = BillingAddress.new(address_params)
  end

  def company_params
    params.require(:worker).permit(:cnpj, :corporate_name,:billing_email)
                           .merge(domain: Company.get_domain(params[:worker][:email]))
  end

  def address_params
    params.require(:worker).permit(:zip_code, :state,:city, :street,
                                   :house_number, :complement, :country)
  end
end
