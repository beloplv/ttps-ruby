class Locality < ApplicationRecord
  has_many :branch_office

  validates :province, uniqueness: {scope: :name}
  validates :province, :name, presence: { message: "fill in the fields" }

  enum :province, [:Buenos_Aires, :Catamarca, :Chaco, :Chubut, :Cordoba, :Corrientes , :Entre_Rios, :Formosa, :Jujuy, :La_Pampa, :La_Rioja, :Mendoza, :Misiones, :Neuquen, :Rio_Negro, :Salta, :San_Juan, :San_Luis, :Santa_Cruz, :Santa_Fe, :Santiago_del_Estero, :Tierra_del_Fuego, :Tucuman]


  def self.return_locality(locality)
    Locality.find_by(id: locality)
  end

end
