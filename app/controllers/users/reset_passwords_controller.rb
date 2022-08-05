class Users::ResetPasswordsController < Users::UsersController
    skip_before_action :authenticate_user

    attr_accessor :error_message

    def new
        redirect_to root_path, error: 'You are already signed in!' and return if current_user
    end

    def create
        @user = User.find_by(email: controller_params[:email])
        if @user.present?
            Users::PasswordMailer.with(user: @user).reset_password.deliver_now
            flash[:notice] = 'Please check you email and follwing the instruction'
            redirect_to root_path and return
        else
            render :new, error: 'Please enter a valid email address' and return
        end
    end

    def edit
        @user = User.find_signed!(controller_params[:token], purpose: 'reset_password')
    end

    def update
        @user = User.find_signed!(params[:token], purpose: 'reset_password')
        if @user.update(password_params)
            redirect_to signin_path, success: 'password changed successfully, signin again'
        else
            flash.now[:error] = @user.errors.full_messages.uniq.to_sentence
            render :edit
        end
    end

    protected

    def controller_params
        params.permit(:email, :token)
    end
end
