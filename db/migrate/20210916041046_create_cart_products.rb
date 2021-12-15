class CreateCartProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_products do |t|

      t.timestamps
      #追加
      t.integer :member_id
      t.integer :product_id
      t.integer :quantity
    end
  end
end
