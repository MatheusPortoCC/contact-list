class ApplicationController < ActionController::API

  def encode_authorization(decoded_token)
    JWT.encode(decoded_token, Rails.application.secrets.secret_key_base.to_s)
  end

  def decode_authorization
    token = request.headers['Authorization']

    if token
      begin
        JWT.decode(token, Rails.application.secrets.secret_key_base.to_s)
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def set_user_authorization
    authorization = decode_authorization[0]

    if Time.current >= Time.parse(authorization['expires_at'])
      render json: { error: 'Authorization expired' }, status: :unauthorized
    else 
      @user = User.find_by_id(authorization['user_id'])

      render json: { errors: 'User not found' }, status: :unauthorized if @user.nil?
    end
  end
  
end
