class LineItemsController < ApplicationController
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart, notice: 'Product successfully added to your cart.' }
        format.json { render json: @line_item, status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to @line_item.cart }
      format.json { head :no_content }
    end
  end

  def update
    # fail
    @line_item = LineItem.find(params[:id])
    puts params[:quantity]

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        @line_item.update_attribute("quantity", params[:quantity])
        format.html { redirect_to @line_item.cart, notice: 'Product quanity was updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @line_item.cart, notice: 'Could not update.' }
        #format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def increase
    LineItem.increase_quantity
  end
end
