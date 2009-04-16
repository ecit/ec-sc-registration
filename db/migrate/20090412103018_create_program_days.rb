class CreateProgramDays < ActiveRecord::Migration
  ProgramDays = [
      ["2009-08-04", "Amithaba initiation"],
      ["2009-08-05", "Phowa"],
      ["2009-08-06", "Phowa"],
      ["2009-08-07", "Phowa"],
      ["2009-08-08", "Phowa"],
      ["2009-08-09", "Phowa"],
      ["2009-08-10", "72h"],
      ["2009-08-11", "72h"],
      ["2009-08-12", "72h"],
      ["2009-08-13", "Chenresig initiation, public lecture"],
      ["2009-08-14", "Mahamudra"],
      ["2009-08-15", "Mahamudra"],
      ["2009-08-16", "Mahamudra"]
  ]
  
  def self.up
    create_table :program_days do |t|
      t.date :date
      t.string :description
      t.timestamps
    end
    
    ProgramDays.each do |date, description|
      ProgramDay.create(:date => date, :description => description)
    end
  end

  def self.down
    drop_table :program_days
  end
end
