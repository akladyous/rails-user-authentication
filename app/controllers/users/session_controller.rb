class Users::SessionController < Users::UsersController

    attr_accessor :error_message

    def new
    end

    def create
        self.error_message = "invalid email or password"
        user = User.find_by!(email: user_params[:email])
        auth = user.authenticate(user_params[:password]) if user
        respond_to do |format|
            if user.present? && auth
                login user
                user.touch :updated_at
                format.html {redirect_to root_path, notice: 'login successfully completed'}
                format.turbo_stream { redirect_to root_path, notice: 'login successfully completed' }
            else
                flash[:alert] = 'Invalid Email or Password'
                format.html { render :new, locals: {user: user}, status: :unprocessable_entity }
                format.turbo_stream { redirect_to :new, locals: {user: user}, status: :unprocessable_entity }
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
