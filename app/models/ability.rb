# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
 
    if user.role == "administrator"
      return unless user.role == "administrator"  # additional permissions for administrators
      
      can :destroy, User do |other_user|
        other_user.id != user.id
      end

      can :create, User
      can :read, User
      can :update, User
      can :manage, BranchOffice
      can :manage, Locality
      can :manage, Schedule
      can :manage, BranchOfficesSchedule

    elsif user.role == "employee"
      return unless user.role == "employee" # additional permissions for employee
      can :read, User do |other_user|
        other_user.id == user.id || other_user.role == "client"
      end

      can :update, User do |other_user|
        other_user.id == user.id
      end

      can :read, Turn, branch_office_id: user.branch_office_id 

      can :update, Turn, branch_office_id: user.branch_office_id 

      can :read, BranchOffice
    
      can :read, BranchOfficesSchedule

      can :read, Schedule
      
    else
      return unless user.role == "client" # additional permissions for client
      can :read, User do |other_user|
        other_user.id == user.id
      end

      can :update, User do |other_user|
        other_user.id == user.id
      end
      
      can :create, Turn

      can :manage, Turn, user_id: user.id

    end
  end    
end