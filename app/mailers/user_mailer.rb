class UserMailer < ActionMailer::Base
  default from: "no-reply@oregonsale.com"

  def order_confirmation(user)
    @user = user

    mail to: "to@example.org"
  end
end
