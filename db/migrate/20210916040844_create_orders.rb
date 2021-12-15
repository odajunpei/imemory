class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.timestamps
      
    #追加
      t.integer :member_id
      t.string  :postal_code
      t.string  :address
      t.string  :name
      t.integer :potage         , default: 800
      t.integer :total_price
      t.integer :payment_method , default: 0
      t.integer :received_status, default: 0
      
    
    end
  end
end
