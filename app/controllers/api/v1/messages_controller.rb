class Api::V1::MessagesController < ApplicationController

  def create
    message = Message.new(message_params)
    conversation = Conversation.find(message_params[:conversation_id])
    if message.save
      
      # this is what adds the message to the conversation 
      # subscribes to the conversation
      MessageChannel.broadcast_to conversation, message
      head :ok
    end
  end

  private

  def message_params
    params.require(:message).permit(:text, :conversation_id)
  end

end