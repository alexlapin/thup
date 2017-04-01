class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:index]

  def index
    @users = User.all
    render json: @users, each_serializer: UserSerializer
  end

end
