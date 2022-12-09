class CreateLocalities < ActiveRecord::Migration[7.0]
  def change
    create_table :localities do |t|
      t.integer :province
      t.string :name

      t.timestamps
    end

    add_index :localities, [:province, :name], unique:true
  
  end
end
