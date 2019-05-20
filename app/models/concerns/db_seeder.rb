require 'faker'

class DbSeeder

  def self.create_users
    5.times do 
      User.create(username: Faker::Name.name, password: '123')
    end
  end

  def self.create_conversations
    10.times do 
      Conversation.create(title: Faker::Book.title)
    end
  end

  def self.create_participants
    20.times do
      Participant.create(user: User.all.sample, conversation: Conversation.all.sample)
    end
  end

  def self.create_messages
    Participant.all.each do |participant|
      5.times do
        Message.create(text: Faker::Quote.matz, user_id: participant.user_id, conversation_id: participant.conversation_id)
      end
    end
  end

  def self.reseed
    User.destroy_all
    Conversation.destroy_all
  end

  def self.run
    self.reseed
    self.create_users
    self.create_conversations
    self.create_participants
    self.create_messages
  end

end