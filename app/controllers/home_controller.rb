class HomeController < ApplicationController
  def show
    @categories = Category.all.sort
    @products = Product.active.shuffle[0..2]  
  end
end
