require 'rails_helper'

describe Item do

  describe 'validations' do

    it 'succeed with a unique title, description, unit_price, and category' do
      item = Item.new(
        title: 'item title',
        description: 'item description',
        unit_price: 9.99,
        category: create(:category)
      )
      expect(item).to be_valid
    end

    it 'succeed with a optional image url' do
      item = Item.new(
        title: 'item title',
        description: 'item description',
        unit_price: 9.99,
        image_url: 'example.com/item.jpg',
        category: create(:category)
      )
      expect(item).to be_valid
    end

    it 'fail when the title is already taken' do
      create(:item, title: 'item title')
      item = Item.new(
        title: 'item title',
        description: 'item description',
        unit_price: 9.99,
        category: create(:category)
      )
      expect(item).to_not be_valid
    end

    it 'fail without a title' do
      item = Item.new(
        description: 'item description',
        unit_price: 9.99,
        category: create(:category)
      )
      expect(item).to_not be_valid
    end

    it 'fail without a description' do
      item = Item.new(
        title: 'item name',
        unit_price: 9.99,
        category: create(:category)
      )
      expect(item).to_not be_valid
    end

    it 'fail without a unit_price' do
      item = Item.new(
        title: 'item name',
        description: 'item description',
        category: create(:category)
      )
      expect(item).to_not be_valid
    end

    it 'fail without a category' do
      item = Item.new(
        title: 'item name',
        description: 'item description',
        unit_price: 9.99,
      )
      expect(item).to_not be_valid
    end
  end

  describe 'defaults' do
    it 'active to true' do
      expect(Item.new.active).to be true
    end

    it 'units to be hourly' do
      expect(Item.new.hourly?).to be true
    end
  end

  describe 'is associated with' do

    before { @item = create(:item) }

    it 'one category' do
      expect(@item.category).to be_a(Category)
    end

  end

end
