class Api::V1::AuthController < ApplicationController

  def create
    user = User.find_by(username: params[:username])
    if user && user.validate(params[:password])
      render json: {user: UserSerializer.new(user)}
    else
      render json: {errors: 'Please enter the correct username and/or password'}
    end
  end

  def auto_login
    if curr_user
      render json: {user: UserSerializer.new(curr_user)}
    else
      render json: {errors: 'Please enter the correct username and/or password'}
    end
  end

end