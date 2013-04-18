class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_store, :set_current_store


  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You can't ford that river (Access denied)"
    redirect_to root_url
  end

  helper_method :current_cart
  helper_method :capture_previous_page
  helper_method :previous_page
  helper_method :current_store

  def current_cart
    @current_cart ||= Cart.find(session[:cart_id])
  rescue
    @current_cart ||= set_current_cart
  end

  def set_current_cart
    unless @current_store.nil?
      cart = Cart.new
      cart.store = current_store
      cart.save!
      session[:carts] ||= {}
      session[:carts][cart.store.id] = cart.id
      session[:cart_id] = cart.id
      return cart
    end
  end

  def capture_previous_page
    session[:referer] = request.env["HTTP_REFERER"]
  end

  def previous_page
    session[:referer]
  end

  def set_current_store
    #reset_session
    unless @current_store.nil?
      if session[:carts] && session[:carts][current_store.id]
        cart_id = session[:carts][current_store.id]
        session[:cart_id] = session[:carts][current_store.id]
      else
        set_current_cart
      end
    end
  end

  def current_store
    @current_store ||= Store.find(params[:store_id])
  end

end
