class BranchOffice < ApplicationRecord
    belongs_to :locality
    has_many :turn, dependent: :destroy
    has_many :user
    has_and_belongs_to_many :schedule, optional:true, dependent: :destroy

    validates :name, :address, :phone, presence: { message: "fill in the fields" }
    validates :name, uniqueness: true

    def self.valid_destroy_locality?(locality)
        branch_offices = BranchOffice.where(locality_id: locality)
        if branch_offices.empty?
            return true
        end
        return false 
    end

    def self.return_branch_office(branch_office)
        BranchOffice.find_by(id: branch_office)
    end

end
