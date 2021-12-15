class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|

      t.timestamps
      #追加
      t.integer :member_id
      t.string  :postal_code
      t.string  :address
      t.string  :name
    end
  end
end
