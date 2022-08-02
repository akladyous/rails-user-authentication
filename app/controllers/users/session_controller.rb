class Users::SessionController < Users::UsersController

    def create
        @user = User.find_by(email: user_params[:email])
        auth = @user.authenticate(user_params[:password])
        respond_to do |format|
            if @user.present? && auth
                login @user
                @user.touch :updated_at
                format.html do
                    redirect_to root_path, notice: 'login successfully completed', status: :ok
                end
                format.turbo_stream { redirect_to root_path, notice: 'ok' }
                return
            else
                flash[:alert] = 'login faild'
                format.html { render :new, status: :unprocessable_entity }
                return
            end
        end
    end

    def destroy
        logout current_user if current_user
        respond_to do |format|
            format.html do
                redirect_to root_path, notice: 'logout compled', status: :ok
            end
            format.turbo_stream { redirect_to root_path(format: :html) }
        end
    end

    def user_params
        params.permit(:email, :password)
    end
end
