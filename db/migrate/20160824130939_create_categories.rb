class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
			t.string	:name
			t.integer	:created_by
			t.references :parent
			t.integer :status

      t.timestamps null: false
    end
  end
end
