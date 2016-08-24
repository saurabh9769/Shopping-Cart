class AddColumnsToAdmin < ActiveRecord::Migration
  def change

  	add_column :admins , :god_mode , :boolean , :default => false
  	add_column :admins , :reports_only , :boolean , :default => false

  end
end
