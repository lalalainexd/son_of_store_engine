class HomeController < ApplicationController
  def show
    @categories = Category.all
  end
end
