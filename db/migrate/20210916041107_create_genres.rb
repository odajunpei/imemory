class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|

      t.timestamps
      #追加
      t.string  :name
      t.string :ancestry
    end
  end
end
