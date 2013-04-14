require 'spec_helper'

describe Product do
  let!(:c1) {Cart.create!}
  let(:p1) do
    Product.new.tap do | product |
      product.name = "name"
      product.description = "description"
      product.store = Store.create!(name:"something", slug:"harhar")
      product.save!
    end
  end

  describe "ensure_not_referenced_by_any_line_item" do
    context "item has no line items" do
      it "returns true" do
        expect(p1.ensure_not_referenced_by_any_line_item).to eq true
      end
    end

    context "item has line items" do
      it "returns false" do
        LineItem.create!(product_id: p1.id, cart_id: c1.id, quantity: 1)
        expect(p1.ensure_not_referenced_by_any_line_item).to eq false
      end
    end
  end
end