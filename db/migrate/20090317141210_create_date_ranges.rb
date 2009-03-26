class CreateDateRanges < ActiveRecord::Migration
  def self.up
    create_table :date_ranges do |t|
      t.date :start_date
      t.date :end_date
      t.integer :arrival_time
      t.integer :departure_time
      t.integer :booking_id
      t.timestamps
    end
  end

  def self.down
    drop_table :date_ranges
  end
end
