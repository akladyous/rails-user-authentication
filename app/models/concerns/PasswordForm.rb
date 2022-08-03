class PasswordForm
    # include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :original_password, :new_password, :new_password_confirmation

    validates_presence_of :original_password, :new_password, :new_password_confirmation
    validates_length_of :new_password, in: 5..64
    validates_confirmation_of :new_password
    validate :verify_original_password

    def initialize(user)
        @user = user
    end

    def verify_original_password
        unless @user.authenticate_password(self.original_password)
            errors.add :original_password, "is not correct"
        end
    end

    def change_password
        @user.password = new_password
    end

    def submit(params)
        self.original_password = params[:original_password]
        self.new_password = params[:new_password]
        self.new_password_confirmation = params[:new_password_confirmation]
        if valid?
            true
        else
            false
        end
    end
end
