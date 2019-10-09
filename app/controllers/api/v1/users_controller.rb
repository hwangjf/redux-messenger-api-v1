class Api::V1::UsersController < ApplicationController
  before_action :authorized, only: [:index]

  def index
    users = User.all

    render json: users, each_serializer: SingleUserSerializer
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
    # user = User.find(params[:id])
    # render json: UserSerializer.new(user)
  end

  def login
    user = User.find_by(username: user_params[:username])
    if user && user.authenticate(user_params[:password])

      render json: {user: UserSerializer.new(user), token: encode_token(user.id)}
    else
      render json: {errors: 'Please enter the correct username and/or password'}, status: :unauthorized
    end
  end

  # TODO: MOVE TO FRIEND CONTROLLER
  def add_friend
    friendship = Friendship.create(user_id: curr_user.id, friend_id: params["friend_id"])

    render json: SingleUserSerializer.new(friendship.friend)
  end

  def remove_friend
    friendship = Friendship.where(user_id: curr_user.id, friend_id: params["friend_id"])

    if friendship
      friendship.destroy
      render json: {removed_friend: SingleUserSerializer.new(friendship.friend), message: 'friend removed'}
    else
      render json: {message: 'that person is not your friend'}
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end