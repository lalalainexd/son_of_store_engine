class LineItemsController < ApplicationController
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])

    quantity = params[:quantity] || 1
    @line_item = @cart.add_product(product, quantity)

    if @line_item.save
      redirect_to :back, notice: 'Product successfully added to your cart.'
    else
      render action: "new"
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    redirect_to @line_item.cart
  end

  def increase
    @line_item = LineItem.find(params[:id])
    if @line_item.increase_quantity
      redirect_to @line_item.cart, notice: 'Product quantity has been updated.'
    else
      raise "AH!"
    end

  end

  def decrease
    @line_item = LineItem.find(params[:id])
    if @line_item && @line_item.quantity <= 1
      @line_item.delete
    else
      @line_item.decrease_quantity
    end

    redirect_to @line_item.cart,
      notice: 'Product quantity has been updated.'
  end
end
