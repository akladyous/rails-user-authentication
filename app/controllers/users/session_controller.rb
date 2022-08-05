class Users::SessionController < Users::UsersController
    skip_before_action :authenticate_user, only: [:new, :create]

    def new
    end

    def create
        @user = User.find_by(email: user_params[:email])
        auth = @user.authenticate(user_params[:password]) if @user
        respond_to do |format|
            if @user.present? && auth
                login @user
                @user.touch :updated_at
                format.html {redirect_to root_path, notice: 'login successfully completed'}
                format.turbo_stream
            else
                flash[:alert] = "invalid email or password"
                format.html { redirect_back_or_to :new, status: :unprocessable_entity  and return}
                format.turbo_stream and return
            end
        end
    end

    def destroy
        logout current_user if current_user
        reset_session
        respond_to do |format|
            flash[:notice] = "logout successfully completed"
            format.html { redirect_to root_path }
            format.turbo_stream { redirect_to root_path } #root_path(format: :html)
        end
    end

    def user_params
        params.permit(:email, :password)
    end
end
