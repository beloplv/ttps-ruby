class Schedule < ApplicationRecord
  has_and_belongs_to_many :branch_office, optional: true, dependent: :destroy

  validates :day, :from, :to, presence: { message: "fill in the fields" }
  
  def self.valid_schedule(from, to)
    from = from.split(':')
    to = to.split(':')
    return from[0] < to[0]
  end

  enum :day, [:monday, :tuesday, :wednesday, :thursday, :friday]
end
