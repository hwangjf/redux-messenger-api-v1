class Api::V1::ConversationsController < ApplicationController
  
  def index
    conversations = Conversation.all
    render json: conversations
  end

  def create
    conversation = Conversation.new(conversation_params)
    if conversation.save
      
      # this is what sends the things involved over this channel
      ActionCable.server.broadcast 'conversation_channel', conversation
      head :ok
    end
  end

  def create_message
    message = Message.create(message_params)
    
  end
    
  private
  
  def conversation_params
    params.require(:conversation).permit(:title)
  end

end