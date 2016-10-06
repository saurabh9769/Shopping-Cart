class CreateContactUs < ActiveRecord::Migration
  def change
    create_table :contact_us do |t|
    	t.text :name
    	t.text :email
    	t.text :contact_no
    	t.text :message
    	t.text :note_admin

      t.timestamps null: false
    end
  end
end
