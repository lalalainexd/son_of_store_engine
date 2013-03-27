class HomeController < ApplicationController
  def show
    @categories = Category.all.sort
    @products = Product.all.shuffle
  end
end
