class CreateBranchOffices < ActiveRecord::Migration[7.0]
  def change
    create_table :branch_offices do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.references :locality, null:false, foreign_key: true
      
      t.timestamps
    end

    add_index :branch_offices, :name, unique: true
  end
end
