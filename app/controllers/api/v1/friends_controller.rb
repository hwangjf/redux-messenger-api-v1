class Api::V1::FriendsController < ApplicationController

  def index
    friends = curr_user.friends
    
    render json: friends
  end

  def create
    friendship = Friendship.create(user_id: curr_user.id, friend_id: params["friend_id"])

    render json: friendship.friend, serializer: SingleUserSerializer
  end

  def destroy
    friendship = Friendship.where(user_id: curr_user.id, friend_id: params["friend_id"])

    if friendship
      friendship.destroy
      render json: {removed_friend: SingleUserSerializer.new(friendship.friend), message: 'friend removed'}
    else
      render json: {message: 'that person is not your friend'}
    end
  end

end