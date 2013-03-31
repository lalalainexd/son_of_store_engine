class HomeController < ApplicationController
  def show
    @categories = Category.all.sort
    @products = Product.where(retired: false).shuffle
    @products_array = @products[0..2] 
  end
end
