class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.integer :day
      t.time :from
      t.time :to

      t.timestamps
    end
    
    add_index :schedules, [:day, :from, :to], unique:true
  end
end
