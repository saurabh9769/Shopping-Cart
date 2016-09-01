class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|

    	t.text :code
    	t.float :percent_off
    	t.integer :created_by , references: :admin
    	t.integer :modify_by , reference: :admin
    	t.integer :no_of_uses

      t.timestamps null: false
    end
  end
end
