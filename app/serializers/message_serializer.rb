class MessageSerializer < ActiveModel::Serializer
  attributes :id, :conversation_id, :text, :created_at, :user
  # belongs_to :user, serializer: UserSerializer
  def user
    UserSerializer.new(object.user)
  end
end
