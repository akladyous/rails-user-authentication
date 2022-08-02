class ApplicationController < ActionController::Base
    before_action :current_user

    protected

    def authenticate_user
        unless current_user
            redirect_to root_path, alert: "You must be signedin" ,status: :unprocessable_entity
        end
    end

    def current_user
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    def login(user)
        session[:user_id] = user.id
    end

    def logout(user)
        session.delete :user_id
    end

    helper_method :current_user
end
