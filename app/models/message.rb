class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  after_create :create_participant
  
  def create_participant
    if !Participant.exists?(user_id: user.id, conversation_id: conversation.id)
      Participant.create(user_id: user.id, conversation_id: conversation.id)
    end
  end
end
