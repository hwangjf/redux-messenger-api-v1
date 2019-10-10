class WelcomeController < ApplicationController
  skip_before_action :authorized

  def index
    render json: 'Hi welcome to redux messenger API'
  end

end