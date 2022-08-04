class Users::ResetPasswordsController < Users::UsersController
    # before_action :method

    attr_accessor :error_message

    def new
        redirect_to root_path, error: 'You are already signed in!' and return if current_user
    end

    def create
        @user = User.find_by(email: controller_params[:email])
        if @user.present?
            Users::PasswordMailer.with(user: @user).reset_password.deliver_now
            redirect_to root_path, notice: 'email found' and return
        else
            self.error_message = 'Please enter a valid email address'
            flash[:error] = self.error_message
            render :new and return
        end
    end

    def edit
        self.error_message = 'Token is expired. Please try again'
        @user = User.find_signed!(controller_params[:token], purpose: 'reset_password')
        rescue ActiveSupport::MessageVerifier::InvalidSignature
            redirect_to reset_user_password_path, error: self.error_message
    end

    def update
        @user = User.find_signed!(params[:token], purpose: 'reset_password')
        # rescue ActiveSupport::MessageVerifier::InvalidSignature
        #     redirect_to reset_user_password_path, error: 'token is expired'
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
