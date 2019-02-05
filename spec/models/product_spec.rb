require 'rails_helper'
RSpec.describe Product, type: :model do

  describe "Factory" do
    let(:product) { FactoryBot.create(:product) }
    
    it "has a valid factory" do
      expect(product).to be_valid
    end
  end

  describe "Validations" do

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:stock) }

    subject { described_class.new(
      name: "Exotic Meats Crate",
      price: 100,
      stock: 10
    )}

    it "is not valid without attributes" do
      expect(subject).to be_valid
    end

    it "is not valid with only one valid attributes :name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with only two valids attributes :name and :price" do
      subject.name = nil
      subject.price = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with only two valids attributes :price and :stock" do
      subject.price = nil
      subject.stock = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with only two valids attributes :name and :stock" do
      subject.name = nil
      subject.stock = nil
      expect(subject).to_not be_valid
    end
  end

  describe "Searcher" do
    it "return all products" do
      product_1 = FactoryBot.create(:product, name: "Product a")
      product_2 = FactoryBot.create(:product, name: "Product b")
      product_3 = FactoryBot.create(:product, name: "Product c")
      all = described_class.search_by_name(nil)
      expect(all.length).to eq 3
    end

    it "returns product found by letter 'a'" do
      product_1 = FactoryBot.create(:product, name: "Product a")
      product_2 = FactoryBot.create(:product, name: "Product b")
      product_3 = FactoryBot.create(:product, name: "Product c")
      prod_a = described_class.search_by_name("a")
      expect(prod_a[0].name).to eq "Product a"
    end

    it "returns product found by exact match 'Product c'" do
      product_1 = FactoryBot.create(:product, name: "Product a")
      product_2 = FactoryBot.create(:product, name: "Product b")
      product_3 = FactoryBot.create(:product, name: "Product c")
      prod_c = described_class.search_by_name("Product c")
      expect(prod_c[0].name).to eq "Product c"
    end

    it "Not valid search" do
      product_1 = FactoryBot.create(:product, name: "Product a")
      product_2 = FactoryBot.create(:product, name: "Product b")
      product_3 = FactoryBot.create(:product, name: "Product c")
      not_prod = described_class.search_by_name("NOT VALID")
      expect(not_prod.length).to eq 0
    end
  end
end
