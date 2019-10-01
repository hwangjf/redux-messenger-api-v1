class UserSerializer < ActiveModel::Serializer
  attributes :id, :username
  has_many :friends, serializer: SingleUserSerializer

  def friends
    object.friends.distinct
  end
end
