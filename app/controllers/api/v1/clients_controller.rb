class Api::V1::ClientsController < ActionController::API

  def  index
    @clients = Client.all

    render json: @clients.as_json(except: [:token, :id, :created_at, :updated_at])
  end

  def create
    @client = Client.new(client_params)
    create_client_token(@client)
    @client.save!

    render json: @client.as_json(except: [:token, :id, :created_at, :updated_at])
  end

  def show
    @client = Client.find_by(id: params[:id])
    render json: @client.as_json(except: [:token, :id, :created_at, :updated_at])
  rescue ActiveRecord::RecordNotFound
    head 404
  end

  private

  def client_params
    params.require(:client).permit(:name, :surname, :cpf)
  end

  def create_client_token(client)
    input = client.cpf + Time.current.to_s + rand.to_s
    client_hash = Digest::SHA256.hexdigest(input)[0..19]
    client.token = client_hash
  end
end
