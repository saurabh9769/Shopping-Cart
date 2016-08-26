class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|

    	t.string :name
    	t.text :sku
    	t.text :short_description
    	t.text :long_description
    	t.float :price
    	t.float :special_price
    	t.date :special_price_from
    	t.date :special_price_to
    	t.integer :status
    	t.integer :quantity
    	t.text :meta_title
    	t.text :meta_description
    	t.text :meta_keyword
    	t.integer :status
    	t.integer :created_by , references: :admins
    	t.integer :modify_by , references: :admins



      t.timestamps null: false
    end
  end
end
