json.extract! order, :id, :product_id, :customer_name, :full_address, :zip_code, :shipping_method, :status, :created_at, :updated_at
json.url order_url(order, format: :json)
