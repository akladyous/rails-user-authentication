class ApplicationController < ActionController::Base

  protected

  def authenticate_user
    unless current_user
      redirect_to root_path, status: :unprocessable_entity and return
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login user
    session[:user_id] = user.id
  end

  def logout user
    session.delete :user_id
  end
end
