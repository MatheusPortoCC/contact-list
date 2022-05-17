class AuthenticationController < ApplicationController
  
  # POST /authentication/login
  def login
    user = User.find_by_email(auth_params[:email])

    if user && user.authenticate(auth_params[:password])
      expires_at = Time.now + 24.hours.to_i

      token = encode_authorization({user_id: user.id, expires_at: expires_at})

      render json: { 
        token: token, 
        expires_at: expires_at.strftime("%m-%d-%Y %H:%M")
      }, status: :ok
    else
      render json: { 
        error: 'Email not found or incorrect password' 
      }, status: :unauthorized
    end
  end

  private

    def auth_params
      params.permit(:email, :password)
    end

end