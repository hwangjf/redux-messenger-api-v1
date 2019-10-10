class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :login]

  def index
    users = User.all

    render json: users, each_serializer: SingleUserSerializer
  end
  
  # signup - create new user
  def create
    user = User.create(user_params)

    if user.valid?
      render json: {user: UserSerializer.new(user), token: encode_token(user.id)}
    else
      render json: user.errors.full_messages
    end
  end
  
  # LOGIN - MOVED TO AUTH CONTROLLER
  def login
    user = User.find_by(username: user_params[:username])
    if user && user.authenticate(user_params[:password])

      render json: {user: UserSerializer.new(user), token: encode_token(user.id)}
    else
      render json: {errors: 'Please enter the correct username and/or password'}, status: :unauthorized
    end
  end

  def update

  end

  def delete

  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end