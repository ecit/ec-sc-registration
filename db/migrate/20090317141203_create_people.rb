class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :type
      t.integer :booking_id
      t.string :first_name
      t.string :last_name
      t.string :country
      t.string :sex
      t.string :email
      t.string :phone_number
      t.integer :age
      t.boolean :parent
      t.boolean :low_income
      t.boolean :helper
      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
