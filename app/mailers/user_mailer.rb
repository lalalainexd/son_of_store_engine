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

  def store_decline_notification(user_email, store_name)
    #@user = user
    @store_name = store_name
    #mail to: user.email
    mail to: user_email
  end
end
