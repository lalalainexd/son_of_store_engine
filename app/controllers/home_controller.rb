class HomeController < ApplicationController
  def show
    @categories = Category.all.sort
    @products = Product.where(retired: false).shuffle
  end
end
