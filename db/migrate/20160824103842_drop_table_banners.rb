class DropTableBanners < ActiveRecord::Migration
  def change
  	drop_table :banners
  end
end
