class Users::PasswordsController < ApplicationController
    before_action :authenticate_user #, :authenticate_user_password

    def new
        @password_form = PasswordForm.new(current_user)
    end

    def update
        # debugger
        @password_form = PasswordForm.new(current_user)
        respond_to do |format|
            if @password_form.submit(password_params)
                current_user.password = new_password_params[:new_password]
                current_user.save
                format.html { redirect_to root_path, notice: 'password changed successfully' and return }
                format.turbo_stream { redirect_to root_path, notice: 'ok' and return}
            else
                # debugger
                flash[:alert] = @password_form.errors
                format.html { render :new, status: :unprocessable_entity }
            end
        end

    end

    # def authenticate_user_password
    #     unless current_user.authenticate(password_params[:password])
    #         render :edit, status: :unprocessable_entity and return
    #     end
    # end
    # def validate_new_password?
    #     new_password_params[:new_password] == new_password_params[:new_password_confirmation]
    # end

    # def password_params
    #     params.require(:user).permit(:password)
    # end

    # def new_password_params
    #     params.permit(:new_password, :new_password_confirmation)
    # end
    def password_params
        params.require(:password_form).permit(:original_password, :new_password, :new_password_confirmation)
    end
end
