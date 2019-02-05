class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true
  validates :stock, presence: true

  scope :search_by_name, ->(name) { where("name ILIKE ?", "%#{name}%") }
end
