class UserMailer < ActionMailer::Base
  default from: "no-reply@epicsale.com"

  def order_confirmation(user, order)
    @user = user
    @confirmation_code = order.confirmation

    mail to: user.email
  end

  def store_approval_confirmation(user, store)
    @user = user
    @store = store
    mail to: user.email
  end
end
