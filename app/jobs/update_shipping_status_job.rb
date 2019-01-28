require 'fedex'

class UpdateShippingStatusJob < ActiveJob::Base
  queue_as :default

  def perform
    create_shipments
    check_shipment_status
  end

  private

  def create_shipments
    Order.is_processing.no_fedex_id.map { |order| create_shipment(order) }
  end

  def check_shipment_status
    Order.shipment.map { |order| process(order) }
  end

  def create_shipment(order)
    shipment = Fedex::Shipment.create
    order.fedex_id = shipment.id
    order.status = shipment.status
    order.save
  end

  def process(order)
    shipment = Fedex::Shipment.find(order.fedex_id.to_i)
    order.status = shipment.status
    order.save
  end
end
