class Api::V1::UserController < Api::BaseController

  def create
    @user = User.new user_params

    if @user.save
      render json: {
        jwt: encode_token({
          id: @user.id,
          firstName: @user.first_name,
          lastName: @user.last_name
        })
      }
    else
      # head :not_found
      render json: { error: @user.errors.full_messages }
    end
  end

    private
    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation
      )
    end
end
