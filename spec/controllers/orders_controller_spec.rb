require 'rails_helper'

describe OrdersController do
  let(:user) { create :user }
  before { sign_in user }

  describe "GET #index" do
    it "populates an array of orders" do
      product_1 = FactoryBot.create(:product, name: "Product a")
      product_2 = FactoryBot.create(:product, name: "Product b")
      order_1   = FactoryBot.create(:order, product_id: product_1.id)
      order_2   = FactoryBot.create(:order, product_id: product_2.id)
      get :index
      expect(assigns(:orders)).to eq([order_1, order_2])
    end

    it "populates an array of orders with filter by order_id" do
      product_1 = FactoryBot.create(:product, name: "Product a")
      product_2 = FactoryBot.create(:product, name: "Product b")
      order_1   = FactoryBot.create(:order, product_id: product_1.id)
      order_2   = FactoryBot.create(:order, product_id: product_2.id)
      get :index, params: { order: 3}
      expect(assigns(:orders)).to eq([order_1])
    end

    it "populates an array of orders with filter by dates" do
      product_1 = FactoryBot.create(:product, name: "Product a")
      product_2 = FactoryBot.create(:product, name: "Product b")
      order_1   = FactoryBot.create(:order, product_id: product_1.id)
      order_2   = FactoryBot.create(:order, product_id: product_2.id)
      get :index, params: { date_from: Date.today, date_to: Date.tomorrow }
      expect(assigns(:orders)).to eq([order_1, order_2])
    end

    it "populates an array of orders with filter by status processing" do
      product_1 = FactoryBot.create(:product, name: "Product a")
      product_2 = FactoryBot.create(:product, name: "Product b")
      order_1   = FactoryBot.create(:order, product_id: product_1.id)
      order_2   = FactoryBot.create(:order, product_id: product_2.id)
      get :index, params: { status: ["processing"] }
      expect(assigns(:orders)).to eq([order_1, order_2])
    end

    it "populates an array of orders with filter by status awaiting_pickup" do
      product_1 = FactoryBot.create(:product, name: "Product a")
      product_2 = FactoryBot.create(:product, name: "Product b")
      order_1   = FactoryBot.create(:order, product_id: product_1.id)
      order_2   = FactoryBot.create(:order, product_id: product_2.id)
      get :index, params: { status: ["awaiting_pickup"] }
      expect(assigns(:orders)).to eq([])
    end
    
    it "renders the :index view" do
      get :index
      assert_template :index
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      let(:product) { FactoryBot.create(:product) }
      let(:post_queue) { post :create, params: { 
        order: {
          product_id: product.id,
          customer_name: "Jhon Doe",
          full_address: "282 Kevin Brook, Imogeneborough, CA 58517",
          zip_code: "58517",
          shipping_method: :country_delivery_within_hours,
          status: :processing
        }
      }}

      it "creates a new order" do
        expect{post_queue}.to change(Order, :count).by(1)
      end
      
      it "redirects to the new order" do
        post :create, params: {
          order: {
            product_id: product.id,
            customer_name: "Jhon Doe",
            full_address: "282 Kevin Brook, Imogeneborough, CA 58517",
            zip_code: "58517",
            shipping_method: :country_delivery_within_hours,
            status: :processing
          }
        }
        expect(response).to redirect_to Order.last
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new order" do
        post :create, params: {
          order: {
            status: :processing
          }
        }
        expect{response}.to_not change(Order, :count)
      end
      
      it "re-renders the new method" do
        post :create, params: {
          order: {
            status: :processing
          }
        }
        expect(response).to render_template :new
      end
    end
  end

end
