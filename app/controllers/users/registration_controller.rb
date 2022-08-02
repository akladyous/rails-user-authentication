class Users::RegistrationController < Users::UsersController
    # skip_before_action :authenticate_user, only: [:new, :create]
    before_action :authenticate_user, except: [:new, :create]

    def new
        @user = User.new
    end

    def create
        respond_to do |format|
            @user = User.new(user_params)
            if @user.save
                login @user
                format.html do
                    redirect_to root_path,
                                notice: 'User was successfully created.' and
                        return
                end
            else
                flash[:alert] = 'user registration failed'
                format.html { render(:new, status: :unprocessable_entity) }
                return
            end
        end
    end

    def cancel
        respond_to do |format|
            if current_user
                format.html { render 'cancel' }
            else
                format.html { redirect_to root_path, notice: 'user not found' }
            end
        end
    end

    def destroy
        user = User.find_by(id: current_user.id)
        user.destroy
        respond_to do |format|
            format.html do
                redirect_to root_path,
                            notice: 'User was successfully destroyed.'
            end
        end
    end

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
