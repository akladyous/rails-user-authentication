class Users::ResetPasswordsController < ApplicationController
    def new
        redirect_to root_path, error: 'You are already signed in!' and return if current_user
    end

    def create
        @user = User.find_by(email: password_params[:email])
        if @user.present?
            Users::PasswordMailer.with(user: @user).reset_password.deliver_now
            redirect_to root_path, notice: 'email found' and return
        else
            render :new, error: 'invalid email' and return
        end
    end

    def edit
        @user = User.find_signed!(params[:token], purpose: 'reset_password')
        # binding.irb
        rescue ActiveSupport::MessageVerifier::InvalidSignature
            redirect_to reset_user_password_path, error: 'token is expired'
    end

    def update
        @user = User.find_signed!(params[:token], purpose: 'reset_password')
        # rescue ActiveSupport::MessageVerifier::InvalidSignature
        #     redirect_to reset_user_password_path, error: 'token is expired'
        # debugger
        if @user.update(password_params)
            redirect_to signin_path, success: 'password changed successfully, signin again'
        else
            flash.now[:error] = @user.errors.full_messages.uniq.to_sentence
            render :edit
        end
    end

    protected

    def password_params
        params.permit(:email, :password, :password_confirmation)
    end
end
