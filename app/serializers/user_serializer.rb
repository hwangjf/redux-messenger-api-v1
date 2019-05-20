class UserSerializer < ActiveModel::Serializer
  attributes :id, :username
  has_many :conversations
  has_many :messages
end
