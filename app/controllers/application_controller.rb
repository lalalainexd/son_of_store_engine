class ApplicationController < ActionController::Base
  protect_from_forgery


  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You can't ford that river (Access denied)"
    redirect_to root_url
  end

  def current_ablity

  end

  helper_method :current_cart
  helper_method :capture_previous_page

  def current_cart
    Cart.find(session[:cart_id])
  rescue
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def capture_previous_page
    session[:referer] = request.env["HTTP_REFERER"]
  end
end
