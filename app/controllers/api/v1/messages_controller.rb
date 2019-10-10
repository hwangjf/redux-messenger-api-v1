class Api::V1::MessagesController < ApplicationController

  def create
    message = Message.new(message_params)
    message.user_id = curr_user.id
    
    if message.save  
      conversation = Conversation.find(message_params[:conversation_id])
      # this is what adds the message to the conversation 
      # subscribes to the conversation
      
      MessageChannel.broadcast_to conversation, MessageSerializer.new(message)
      render json: message
    end
  end

  def patch
    message = Message.find(params['message_id'])

    if message.update(params['text'])
      conversation = Conversation.find(message_params[:conversation_id])
      
      MessageChannel.broadcast_to conversation, MessageSerializer.new(message)
      render json: message
    end
  end

  def delete

  end

  private

  def message_params
    params.require(:message).permit(:text, :conversation_id)
  end

end