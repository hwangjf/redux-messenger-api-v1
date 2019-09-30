class UserSerializer < ActiveModel::Serializer
  attributes :id, :username
  has_many :friends, serializer: FriendSerializer

  def friends
    object.friends.distinct
  end
end
