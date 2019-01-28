class Order < ApplicationRecord

  # relations
  belongs_to :product

  # validations
  validates :customer_name, presence: true
  validates :full_address, presence: true
  validates :shipping_method, presence: true

  # enums
  enum status: [:processing, :awaiting_pickup, :in_transit, :out_for_delivery, :delivered]
  enum shipping_method: [
    :country_delivery_within_hours,
    :city_delivery_within_hours,
    :first_thing_next_business_day_morning,
    :next_business_day_morning
  ]

  # scopes
  scope :is_processing, -> { where(status: :processing) }
  scope :no_fedex_id, -> { where(fedex_id: nil) }
  scope :shipment, -> { where.not(fedex_id: nil) }

  def self.search_by_filters(filters)
    order = Order.all
    order = order.where(id: filters[:order]) if filters[:order].present?
    order = order.where(
      created_at: filters[:date_from].to_date.beginning_of_day..filters[:date_to].to_date.end_of_day
    ) if filters[:date_from].present? && filters[:date_to].present?
    order = order.where(status: filters[:status]) if filters[:status].present?
    order
  end
end
