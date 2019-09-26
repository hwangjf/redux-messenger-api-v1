class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :messages, serializer: MessageSerializer
end
