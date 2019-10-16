class Api::V1::ConversationsController < ApplicationController
  
  def index
    conversations = Conversation.all

    render json: conversations, include: '**'
  end

  def create
    conversation = Conversation.find_or_create_by(conversation_params)
    if conversation || conversation.save
      # this is what sends the things involved over this channel
      ActionCable.server.broadcast 'conversation_channel', conversation
      render json: conversation
    end
  end

  def update
    conversation = Conversation.find_or_initialize_by(conversation_params)
    if conversation || conversation.update
      # this is what sends the things involved over this channel
      ActionCable.server.broadcast 'conversation_channel', conversation
      render json: conversation
    end
  end

  def delete
    conversation = Conversation.find(params[:id])
  end
    
  private
  
  def conversation_params
    params.require(:conversation).permit(:title)
  end

end