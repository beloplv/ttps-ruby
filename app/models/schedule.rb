class Schedule < ApplicationRecord
  has_and_belongs_to_many :branch_office, optional: true, dependent: :destroy

  validates :day, :from, :to, presence: { message: "fill in the fields" }
  validates :day, uniqueness: { scope: [:from, :to ], message: ": That schedule already exists for that day"} 
  
  def self.valid_schedule?(from, to)
    if from != "" && to != ""
      from = from.split(':')
      to = to.split(':')
      return from[0] < to[0]
    else
      return false
    end
  end

  def self.return_schedule(schedule)
    Schedule.find_by(id: schedule)
  end

  enum :day, [:monday, :tuesday, :wednesday, :thursday, :friday]
end
