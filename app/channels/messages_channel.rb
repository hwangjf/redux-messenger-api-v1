class MessagesChannel < ApplicationCable::Channel
   def subscribed
    conversation = Conversation.find(params[:conversation])
    # can use object instead of unique string but MUST BE UNIQUE
    stream_for conversation
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
