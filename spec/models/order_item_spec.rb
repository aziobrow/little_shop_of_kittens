require 'rails_helper'

describe OrderItem do

  describe 'validations' do

    it 'pass with an order, item, and quantity' do
      order_item = OrderItem.new(
        order: create(:order),
        item: create(:item),
        quantity: 1,
      )
      expect(order_item).to be_valid
    end

    it 'fail without an order' do
      order_item = OrderItem.new(
        item: create(:item),
        quantity: 1,
      )
      expect(order_item).to_not be_valid
    end

    it 'fail without an item' do
      order_item = OrderItem.new(
        order: create(:order),
        quantity: 1,
      )
      expect(order_item).to_not be_valid
    end

    it 'fail without a quantity' do
      order_item = OrderItem.new(
        order: create(:order),
        item: create(:item),
      )
      expect(order_item).to_not be_valid
    end

  end

  describe 'defaults' do
    it 'original_unit_price to the item\'s unit_price' do
      order_item = create(:order_item)
      expect(order_item.original_unit_price).to eq(order_item.item.unit_price)
    end

    it 'units to be hourly' do
      expect(OrderItem.new.hourly?).to be true
    end
  end

  describe 'is associated with' do

    before { @order_item = create(:order_item) }

    it 'one order' do
      expect(@order_item.order).to be_a Order
    end

    it 'one item' do
      expect(@order_item.item).to be_a Item
    end

  end

  describe 'instance methods' do
    it '#subtotal returns the original_unit_price * quantity in cents' do
      order_item = create(:order_item, original_unit_price: 199, quantity: 2)
      expect(order_item.subtotal).to eq(398)
    end
  end

end
