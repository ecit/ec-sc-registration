class CreateDateRanges < ActiveRecord::Migration
  def self.up
    create_table :date_ranges do |t|
      t.date :start
      t.date :end
      t.integer :arrival
      t.integer :departure
      t.integer :booking_id
      t.timestamps
    end
  end

  def self.down
    drop_table :date_ranges
  end
end
