class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :product, foreign_key: true
      t.string :customer_name
      t.string :full_address
      t.string :zip_code
      t.integer :shipping_method
      t.integer :status, default: 0
      t.string :fedex_id

      t.timestamps null: false
    end
  end
end
