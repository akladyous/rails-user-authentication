# Preview all emails at http://localhost:3000/rails/mailers/users/password_mailer
class Users::PasswordMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/users/password_mailer/reset_password
  def reset_password
    Users::PasswordMailer.reset_password
  end

end
