require 'rails_helper'
RSpec.describe Order, type: :model do

  describe "Associations" do
    it { should belong_to(:product) }
  end

  describe "Validations" do
    it { should validate_presence_of(:customer_name) }
    it { should validate_presence_of(:full_address) }
    it { should validate_presence_of(:shipping_method) }
  end

  describe "Enumerators" do
    it "Enum :status"do
      should define_enum_for(:status).
        with([
          :processing,
          :awaiting_pickup,
          :in_transit,
          :out_for_delivery,
          :delivered
        ])
    end

    it "Enum :shipping_method"do
      should define_enum_for(:shipping_method).
        with([
          :country_delivery_within_hours,
          :city_delivery_within_hours,
          :first_thing_next_business_day_morning,
          :next_business_day_morning
        ])
    end
  end

  describe "Factory" do
    let(:product) { FactoryBot.create(:product) }
    let(:order) { Order.create(
      product_id: product.id,
      customer_name: "Jhon Doe",
      full_address: "Av 123, Street 8",
      zip_code: "90011",
      shipping_method: :country_delivery_within_hours,
    )}
    
    it "has a valid factory" do
      expect(order).to be_valid
    end

    it "has default status processing" do
      expect(order.status).to eq "processing"
    end

    it "has default fedex_id as null" do
      expect(order.fedex_id).to eq nil
    end
  end

  describe "Search" do    
    it "return order found by id" do
      product_1 = FactoryBot.create(:product, name: "Product a")
      product_2 = FactoryBot.create(:product, name: "Product b")
      order_1   = FactoryBot.create(:order, product_id: product_1.id)
      order_2   = FactoryBot.create(:order, product_id: product_2.id)
      search = described_class.search_by_filters({params: {order: 1}})
      expect(search).to exist
    end

    it "returns orders found between two dates" do
      product = FactoryBot.create(:product, name: "Product a")
      order_1   = FactoryBot.create(:order, product_id: product.id)
      order_2   = FactoryBot.create(:order, product_id: product.id)
      search = described_class.search_by_filters({params: {date_from: Date.today, date_to: Date.today}})
      expect(search.length).to eq 2
    end

    it "return orders found by status" do
      product = FactoryBot.create(:product, name: "Product a")
      order_1   = FactoryBot.create(:order, product_id: product.id)
      order_2   = FactoryBot.create(:order, product_id: product.id)
      search = described_class.search_by_filters({params: {status: :processing}})
      expect(search.length).to eq 2
    end

    it "Not valid search return all orders" do
      product = FactoryBot.create(:product, name: "Product a")
      order_1   = FactoryBot.create(:order, product_id: product.id)
      order_2   = FactoryBot.create(:order, product_id: product.id)
      order_3   = FactoryBot.create(:order, product_id: product.id)
      search = described_class.search_by_filters({params: {}})
      expect(search.length).to eq 3
    end
  end
end
