require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "save is successful if all the fields are filled out" do
      @categories = Category.new(:name => "Orchids")
      @product = Product.new(:name => "Orchis fatalis",  :price => 100000, :quantity => 1, :category =>@categories)
      expect(@product).to be_valid 
    end

    it "checks for an entry into name and returns error if nil" do 
      @categories = Category.new(:name => "Orchids")
      @product = Product.new(:name => nil,  :price => 100000, :quantity => 1, :category =>@categories)
      expect(@product).not_to be_valid 
      expect(@product.errors.full_messages[0]).to eq("Name can't be blank")
    end

    it "validates the presence of price_cents and price" do 
      @categories = Category.new(:name => "Orchids")
      @product = Product.new(:name => "Orchis fatalis", :price => nil, :price_cents =>nil, :quantity => 1, :category =>@categories)
      expect(@product).not_to be_valid 
      expect(@product.errors.full_messages[0]).to eq("Price cents is not a number")
      expect(@product.errors.full_messages[1]).to eq("Price is not a number")
      expect(@product.errors.full_messages[2]).to eq("Price can't be blank")
    end 

    it "validates the presence of quantity" do 
      @categories = Category.new(:name => "Orchids")
      @product = Product.new(:name => "Orchis fatalis", :price => 100000, :quantity =>nil, :category =>@categories)
      expect(@product).not_to be_valid 
      expect(@product.errors.full_messages[0]).to eq("Quantity can't be blank")
    end 

    it "validates the presence of category" do 
      @categories = Category.new(:name => "Orchids")
      @product = Product.new(:name => "Orchis fatalis", :price => 100000, :quantity =>1, :category =>nil )
      expect(@product).not_to be_valid 
      expect(@product.errors.full_messages[0]).to eq("Category must exist")
    end
  end
end
