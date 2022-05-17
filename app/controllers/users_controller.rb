class UsersController < ApplicationController

  # POST /users
  def create
    user = User.create(user_params)

    if user.valid?
      expires_at = Time.now + 24.hours.to_i

      token = encode_authorization({user_id: user.id, expires_at: expires_at})

      render json: { 
        token: token, 
        expires_at: expires_at.strftime("%m-%d-%Y %H:%M")
      }, status: :ok
    else
      render json: {
        error: user.errors
      }, status: :ok
    end
  end

  private

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
    
end