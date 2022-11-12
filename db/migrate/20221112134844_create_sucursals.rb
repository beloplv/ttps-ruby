class CreateSucursals < ActiveRecord::Migration[7.0]
  def change
    create_table :sucursals do |t|
      t.string :nombre
      t.string :direccion
      t.integer :telefono

      t.timestamps
    end
  end
end
