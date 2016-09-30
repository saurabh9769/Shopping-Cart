class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
    	t.integer :order_id
    	t.integer :totalvalue
    	t.text :stripe_token
    	t.text :stripe_token_type
    	t.text :stripe_email

      t.timestamps null: false
    end
  end
end
