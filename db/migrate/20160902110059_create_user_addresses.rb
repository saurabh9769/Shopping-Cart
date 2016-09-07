class CreateUserAddresses < ActiveRecord::Migration
  def change
    create_table :user_addresses do |t|

    	t.integer :user_id
    	t.text :address_1
    	t.text :address_2
    	t.text :city
    	t.text :state
    	t.text :country
    	t.text :zipcode

      t.timestamps null: false
    end
  end
end
