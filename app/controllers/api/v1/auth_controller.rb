class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized
  
  def login
    user = User.find_by(username: params[:user][:username])
    if user && user.validate(params[:user][:password])
      render json: {user: UserSerializer.new(user)}
    else
      render json: {errors: 'Please enter the correct username and/or password'}
    end
  end
  
  def auto_login
    if curr_user
      render json: {user: UserSerializer.new(curr_user)}
    else
      render json: {errors: 'Please enter the correct username and/or password'}, status: :unauthorized
    end
  end

end