class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
	  t.integer :post_year
	  t.integer :post_month
	  t.integer :post_numberof
	
      t.timestamps
    end
  end
end
