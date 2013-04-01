class LineItemsController < ApplicationController
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to :back, notice: 'Product successfully added to your cart.' }
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
    # @line_item = LineItem.find(params[:id])

    # respond_to do |format|
    #   if @line_item.update_attributes(params[:line_item])
    #     format.html { redirect_to @line_item.cart, notice: 'Product quanity was updated.' }
    #     format.json { head :no_content }
    #   else
    #     format.html { redirect_to @line_item.cart, notice: 'Could not update.' }
    #     #format.json { render json: @line_item.errors, status: :unprocessable_entity }
    #   end
    # end

    # it seems to me we don't use this. correct me if wrong.
  end

  def increase
    @line_item = LineItem.find(params[:id])
    if @line_item
      @line_item.update_attribute("quantity", @line_item.increase_quantity)
      redirect_to @line_item.cart, notice: 'Product quantity has been updated.'
    end
  end

  def decrease
    @line_item = LineItem.find(params[:id])
    if @line_item
      if @line_item.quantity <= 1
        @line_item.delete
        redirect_to @line_item.cart, notice: 'Product quantity has been updated.'
      else
        @line_item.update_attribute("quantity", @line_item.decrease_quantity)
        redirect_to @line_item.cart, notice: 'Product quantity has been updated.'
      end
    end
  end
end
