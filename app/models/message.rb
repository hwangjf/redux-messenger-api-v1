class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  after_create :create_participant
  
  def create_participant
    if !Participant.where(user_id: self.user.id, conversation_id: self.conversation.id)
      Participant.create(user_id: self.user.id, conversation_id: self.conversation.id)
    end
  end
end
