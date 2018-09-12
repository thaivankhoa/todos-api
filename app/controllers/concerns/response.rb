# app/controllers/concerns/response.rb
module Response
  def json_response(object, status = :ok)
    render json: TodoSerializer.new(object).serializable_hash, status: status
  end
end