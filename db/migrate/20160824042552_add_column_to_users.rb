class AddColumnToUsers < ActiveRecord::Migration
  def change

  	add_column :users, :god_mode, :boolean, default: false

  end
end
