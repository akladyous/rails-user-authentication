class Users::PasswordMailer < ApplicationMailer

    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.users.password_mailer.reset_password.subject
    #
    def reset_password
        @token = params[:user].signed_id(purpose: 'reset_password', expires_in: 90.minutes)
        @user = params[:user]
        mail to: @user.email, subject: "reset account password"
    end
end
