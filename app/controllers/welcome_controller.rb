class WelcomeController < ApplicationController

  def index
    render json: 'Hi welcome to redux messenger API'
  end

end