class AddColumnToBanners < ActiveRecord::Migration
  def change
  	add_column :banners, :body , :text
  end
end
