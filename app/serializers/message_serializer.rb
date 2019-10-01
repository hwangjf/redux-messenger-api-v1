class MessageSerializer < ActiveModel::Serializer
  attributes :id, :conversation_id, :text, :timestamp

  belongs_to :user, serializer: SingleUserSerializer

  def timestamp
    object.created_at.localtime.to_formatted_s(:short)
  end
end
