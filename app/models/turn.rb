class Turn < ApplicationRecord
    belongs_to :branch_office
    belongs_to :user
    belongs_to :employee, class_name: "User", optional: true

    validates :date, :hour, :motive, presence: { message: "fill in the fields" }
  
    enum :status, [:in_progress, :attended]

    def self.valid_destroy_branch_office?(branch_office)
        turns = Turn.where(branch_office_id: branch_office)
        turns.each do |x|
            if x.result == "in_progress"
                return false
            end
        end
        return true 
    end

    def self.destroy_turns_users(user)
        turns = Turn.where('employee_id=? OR user_id=?', user, user)
        turns.each do |x|
            x.destroy
        end
    end 

    def self.valid_destroy_branch_offices_schedule?(branch_office, schedule)
        turns = Turn.where(branch_office_id: branch_office)
        schedule = Schedule.find_by(id: schedule)
        turns.each do |x|
            if x.status == "in_progress"
                if x.hour.strftime("%H:%M").between?(schedule.from.strftime("%H:%M"),schedule.to.strftime("%H:%M")) && x.date.strftime("%A").downcase == schedule.day
                    return false
                end
            end
        end
        return true 
    end

    def self.return_turns_client(client)
        Turn.where(user_id: client)
    end

    def self.return_turns_employee(employee)
        branch_office = User.find_by(id: employee)
        Turn.where(branch_office_id: branch_office.branch_office_id)
    end
end
