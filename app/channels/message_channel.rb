class MessageChannel < ApplicationCable::Channel
   def subscribed
    conversation = Conversation.find(params[:conversation_id])
    # can use object instead of unique string but MUST BE UNIQUE

    stream_for conversation
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    puts '**********************************************************'
    puts '**********************************************************'
    puts '**********************************************************'
    puts '**********************************************************'
  end
end
