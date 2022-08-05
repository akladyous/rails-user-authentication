class Users::EditPasswordsController < ApplicationController

    def new
        @password_form = PasswordForm.new(current_user)
    end

    def update
        @password_form = PasswordForm.new(current_user)
        respond_to do |format|
            if @password_form.submit(password_params)
                current_user.password = password_params[:original_password]
                current_user.save!
                format.html { redirect_to root_path, notice: 'password changed successfully' and return }
                format.turbo_stream { redirect_to root_path, notice: 'ok' and return}
            else
                flash[:alert] = @password_form.errors.full_messages.to_sentence
                format.html { render :new, status: :unprocessable_entity }
            end
        end

    end

    def password_params
        params.require(:password_form).permit(:original_password, :new_password, :new_password_confirmation)
    end
end
