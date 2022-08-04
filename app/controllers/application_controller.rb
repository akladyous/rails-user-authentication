class ApplicationController < ActionController::Base
    before_action :current_user
    add_flash_types :warning, :error, :info, :success

    # rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
    rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_association
    rescue_from AbstractController::DoubleRenderError, with: :interal_error
    rescue_from ActiveRecord::RecordNotSaved, with: :failed_to_save

    helper_method :current_user


    protected
    def authenticate_user
        unless current_user
            redirect_to root_path, error: "User not authorized" # ,status: :unprocessable_entity
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
    # exception methods
    def invalid_record(exception)
        render json: {error: exception.record.errors.full_messages}, status: :unprocessable_entity
    end
    def record_not_found(exception)
        # debugger
        flash.now[:notice] = self.error_message
        # render action_name, status: :unprocessable_entity
        render :new, status: :unprocessable_entity
    end
    def record_not_unique(exception)
        render json: {error: exception.message}, status: :unprocessable_entity
    end
    def invalid_association(exception)
        render json: {error: "Unprocessable request"}, status: :unprocessable_entity
    end
    def failed_to_save
        render json: {error: "Failed to save the record"}, status: :unprocessable_entity
    end
    def interal_error
        render json: {error: "Internal Error"}, status: :unprocessable_entity
    end
    def render_unprocessable
        render json: {error: "Unprocessable request"}, status: :unprocessable_entity
    end
    def render_not_found
        render json: {error: "Record not Found"}, status: :not_found
    end
    def render_ok obj
        render json: obj, status: :ok
    end
end
