class Product < ActiveRecord::Base

  require 'roo'
	enum status: { active: 1 ,  inactive: 0 }

	belongs_to :category
	has_many :product_images
	has_many :order_details
	has_many :orders, through: :order_details
	has_many :user_wish_lists
	has_many :users, through: :user_wish_lists

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by_id(row["id"]) || new
      product.attributes = row.to_hash.slice("name", "price", "status", "created_at", "category_id")
      product.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::CSV.new(file.path, nil, :ignore)
    when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
    when '.xlsx' then Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

end
