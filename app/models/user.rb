class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :branch_office, optional:true
  has_many :turn, dependent: :destroy


  validates :role, presence: { message: "fill in the fields" }

  enum :role, [:administrator, :employee, :client]


  def self.valid_destroy_branch_office?(branch_office)
    users = User.where(branch_office_id: branch_office)
    if users.empty?
      return true
    end
    return false 
  end
end
