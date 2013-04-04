class UserMailer < ActionMailer::Base
  default from: "no-reply@oregonsale.com"

  def order_confirmation(user, order)
    @user = user
    @confirmation_code = order.confirmation

    mail to: user.email
  end
end
