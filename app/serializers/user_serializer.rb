class UserSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :conversations
  has_many :messages
end
