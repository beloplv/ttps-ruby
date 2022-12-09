class CreateTurns < ActiveRecord::Migration[7.0]
  def change
    create_table :turns do |t|
      t.date :date
      t.time :hour
      t.string :motive
      t.integer :status, default: 0
      t.string :result, null: true
      t.references :branch_office, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: {to_table: :users}
      t.references :employee, null: true, foreign_key: {to_table: :users}
      
      t.timestamps
    end
  end
end
