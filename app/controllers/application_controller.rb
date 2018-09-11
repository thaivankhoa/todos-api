class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  # called before every action on controllers
  before_action :authorize_request
  attr_reader :current_user

  private

  # Check for valid request token and return user
  def authorize_request
    # request.headers["Authorization"] = JsonWebToken.encode(user_id: 1)
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end
