class Users::UsersController < ApplicationController
    # skip_before_action :authenticate_user, only: %i[new create]

    protected

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
    def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end
