class RemoveColumnFromUsers < ActiveRecord::Migration
  def change

  	remove_column :users , :god_mode
  end
end
