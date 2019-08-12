class Api::V1::UsersController < ApplicationController
  before_action :authorized, only: [:index]

  def index
    users = User.all

    render json: users
  end
  
  def signup
    user = User.create(user_params)

    if user.valid?
      render json: {user: UserSerializer.new(user), token: encode_token(user.id)}
    else
      render json: user.errors.full_messages
    end
  end
  
  def show
    render json: curr_user
  end

  def login
    user = User.find_by(username: user_params[:username])
    if user && user.authenticate(user_params[:password])

      render json: {user: UserSerializer.new(user), token: encode_token(user.id)}
    else
      render json: {errors: 'Please enter the correct username and/or password'}, status: :unauthorized
    end
  end

  def auto_login
    if logged_in
      render json: {user: UserSerializer.new(curr_user)}
    else
      render json: {errors: 'Please enter the correct username and/or password'}, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end