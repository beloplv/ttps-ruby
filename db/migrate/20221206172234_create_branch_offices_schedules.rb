class CreateBranchOfficesSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :branch_offices_schedules do |t|
      t.references :branch_office, null: false, foreign_key: true
      t.references :schedule, null: false, foreign_key: true

      t.timestamps
    end
  end
end
