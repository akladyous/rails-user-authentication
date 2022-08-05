class Users::UsersController < ApplicationController
    layout "users"
    before_action :authenticate_user

    protected

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
    def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end
