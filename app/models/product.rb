class Product < ActiveRecord::Base
  scope :search_by_name, ->(name) { where("name ILIKE ?", "%#{name}%") }
end
