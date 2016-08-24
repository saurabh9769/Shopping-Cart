class RemoveColumnFromAdmins < ActiveRecord::Migration
  def change

  	remove_column :admins , :god_mode
  	remove_column :admins , :reports_only

  end
end
