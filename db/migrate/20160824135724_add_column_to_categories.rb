class AddColumnToCategories < ActiveRecord::Migration
  def change

  	add_column :categories , :modify_by , :integer

  end
end
