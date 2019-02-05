require 'rails_helper'

describe ProductsController do
  describe "GET #index" do
    it "populates an array of products" do
      product = FactoryBot.create(:product)
      get :index
      expect(assigns(:products)).to eq([product])
    end
    
    it "renders the :index view" do
      get :index
      assert_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested product to @product" do
      product = FactoryBot.create(:product)
      get :show, params: { id: product }
      expect(assigns(:product)).to eq(product)
    end
    
    it "renders the #show view" do
      get :show, params: { id: FactoryBot.create(:product) }
      assert_template :show
    end
  end
end
