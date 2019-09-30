class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :title, :users
  has_many :messages, serializer: MessageSerializer
  # has_many :users, serializer: UserSerializer

  def users
    ActiveModel::Serializer::ArraySerializer.new(object.users.uniq, each_serializer: UserSerializer)
  end

end
