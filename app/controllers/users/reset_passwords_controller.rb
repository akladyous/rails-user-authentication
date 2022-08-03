class Users::ResetPasswordsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: email_params[:email])
        redirect_to root_path, error: 'invalid email' unless @user.present? and return
        redirect_to root_path, notice: 'email found'
    end

    def email_params
        params.permit(:email)
    end
end
