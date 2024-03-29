class Users::RegistrationController < Users::UsersController
    skip_before_action :authenticate_user, only: [:new, :create]

    def new
        @user = User.new
    end

    def create
        respond_to do |format|
            @user = User.new(user_params)
            if @user.save
                login @user
                flash[:notice] = 'User account was successfully created'
                format.html { redirect_to root_path }
                format.turbo_stream
            else
                flash[:alert] = 'User registration failed'
                format.html { render(:new, status: :unprocessable_entity) }
                format.turbo_stream

            end
        end
    end

    def cancel
        respond_to do |format|
            if current_user
                format.html { render 'cancel' }
            else
                format.html { redirect_to root_path, error: 'user not found' }
                format.turbo_stream
            end
        end
    end

    def destroy
        user = User.find_by(id: current_user.id)
        user.destroy
        respond_to do |format|
            format.html { redirect_to root_path, notice: 'User account has been successfully deleted' }
            format.turbo_stream
        end
    end

end
