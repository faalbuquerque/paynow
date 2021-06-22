class Api::V1::ClientsController < ActionController::API
  def  index
    @clients = Client.all
    render json: @clients.as_json(except: [:token, :id, :created_at, :updated_at])
  end

  def create
    @company = Company.find_by(token: params[:client][:company_token])
    @client = Client.find_by(cpf: params[:client][:cpf])

    unless @company
      return render json: { message: 'parâmetros inválidos' }
    end

    unless @client
      @client = Client.create!(client_params)
      @client.create_client_token
      @client.save!
    end

    unless @client.company_tokens.exists?(company_id: @company.id)
      @client.company_tokens.create!(token: @company.token, company_id: @company.id)
    end

    render json: @client.as_json(except: [:token, :id, :created_at, :updated_at])
  end

  def show
    @client = Client.find_by(id: params[:id])
    render json: @client.as_json(except: [:token, :id, :created_at, :updated_at])
  end

  private

  def client_params
    params.require(:client).permit(:name, :surname, :cpf)
  end
end
