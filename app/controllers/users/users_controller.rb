module Users
    # class Users::UsersController < ApplicationController
    class UsersController < ApplicationController
        # skip_before_action :authenticate_user, only: %i[new create]

        # protected
        # def authenticate_user
        #     debugger
        #     unless current_user
        #         redirect_to root_path, alert: "You must be signedin" ,status: :unprocessable_entity
        #     end
        # end

        # def new
        #     @user = User.new
        # end

        # def create
        #     respond_to do |format|
        #         @user = User.new(user_params)
        #         if @user.save
        #             login @user
        #             format.html do
        #                 redirect_to root_path,
        #                             notice: 'User was successfully created.' and
        #                     return
        #             end
        #         else
        #             flash[:alert] = 'user registration failed'
        #             format.html { render(:new, status: :unprocessable_entity) }
        #             return
        #         end
        #     end
        # end

        # def cancel
        #     respond_to do |format|
        #         if current_user
        #             format.html { render 'cancel' }
        #         else
        #             format.html { redirect_to root_path, notice: 'user not found' }
        #         end
        #     end
        # end

        # def destroy
        #     user = User.find_by(id: current_user.id)
        #     user.destroy
        #     respond_to do |format|
        #         format.html do
        #             redirect_to root_path,
        #                         notice: 'User was successfully destroyed.'
        #         end
        #     end
        # end

        def user_params
            params.require(:user).permit(:email, :password, :password_confirmation)
        end
    end

end
