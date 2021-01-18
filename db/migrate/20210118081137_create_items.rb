class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :titile,       null: false, default: ""
      t.text :content,        null: false
      t.integer :category_id, null: false
      t.integer :status_id,   null: false
      t.integer :delivery_id, null: false
      t.integer :place_id,    null: false
      t.integer :duration_id, null: false
      t.integer :price,       null: false
      t.timestamps
    end
  end
end
