class CreateOrderProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_products do |t|

      t.timestamps
    #追加
      t.integer :product_id
      t.integer :order_id
      t.integer :subtotal_price
      t.integer :quantity
      t.integer :production_status , default: 0
    end
  end
end
