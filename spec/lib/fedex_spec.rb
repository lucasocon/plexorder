require 'rails_helper'
require 'fedex'

RSpec.describe Fedex do
  describe "Create Shipment" do
    it "has default status :awaiting_pickup" do
      shipment = Fedex::Shipment.create
      expect(shipment.status).to eq "awaiting_pickup"
    end
  end

  describe "Find Shipment" do
    it "has updated status" do
      shipment = Fedex::Shipment.find(1)
      expect([
        'awaiting_pickup',
        'in_transit',
        'out_for_delivery',
        'delivered'
      ]).to include(shipment.status)
    end
  end
end
