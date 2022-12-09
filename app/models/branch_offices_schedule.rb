class BranchOfficesSchedule < ApplicationRecord
  belongs_to :branch_office
  belongs_to :schedule

  def self.valid_branch_office_schedule(b_id, s_id, ok)
    coincidence = BranchOfficesSchedule.where(branch_office_id: b_id)
    schedule_select = Schedule.find_by(id: s_id)
    coincidence.each do |x|
      schedule_current = Schedule.find_by(id: x.schedule_id)
      if ok
        if !schedule_current.id == schedule_select.id
          if schedule_current.day == schedule_select.day 
            return false
          end
        end 
      else
        if schedule_current.day == schedule_select.day
          return false
        end
      end
    end
    return true
 end
 
  def self.valid_turn(b_id, date, hour)
    coincidence = BranchOfficesSchedule.where(branch_office_id: b_id)
    coincidence.each do |x|
    schedule = Schedule.find_by(id: x.schedule_id)
    if schedule.day == date.to_datetime.strftime("%A").downcase 
      if hour.to_datetime.strftime("%H:%M").between?(schedule.from.strftime("%H:%M"),schedule.to.strftime("%H:%M"))
        if date.to_date >= DateTime.now.to_date
          return true
        end
      end
    end
    end
    return false
  end

  def self.in_progress?(status)
    return status == "in_progress"
  end

  def self.valid_destroy_schedule?(schedule)
    branch_offices_schedule = BranchOfficesSchedule.where(schedule_id: schedule)
    if branch_offices_schedule.empty?
      return true
    end
    return false
  end 

end
