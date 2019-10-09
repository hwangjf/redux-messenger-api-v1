class ApplicationController < ActionController::API

  def encode_token(user_id)
    JWT.encode({user_id: user_id}, ENV['TOKEN_SECRET'])
  end

  def auth_headers # check for headers and return token
    request.headers["Authorization"].split(' ')[1]
    # headers exist -> check key Authorization -> ['Bearer', 'token']
    # return 'token'
  end

  def decoded_token
    begin
      JWT.decode(auth_headers, ENV['TOKEN_SECRET'])
    rescue
      nil
    end
  end
  
  def curr_user
    begin
      user_id = decoded_token[0]['user_id']
      user = User.find(user_id)
    rescue
      nil
    end
  end
  
  def logged_in
    !!curr_user
  end

  def authorized
    render json: {errors: 'Please log in'}, status: :unauthorized unless logged_in
  end
end
