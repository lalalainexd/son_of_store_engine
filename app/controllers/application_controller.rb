class ApplicationController < ActionController::Base
  protect_from_forgery


  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  protected

  def current_cart
    Cart.find(session[:cart_id])
  rescue
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
