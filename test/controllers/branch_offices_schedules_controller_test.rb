require "test_helper"

class BranchOfficesSchedulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @branch_offices_schedule = branch_offices_schedules(:one)
  end

  test "should get index" do
    get branch_offices_schedules_url
    assert_response :success
  end

  test "should get new" do
    get new_branch_offices_schedule_url
    assert_response :success
  end

  test "should create branch_offices_schedule" do
    assert_difference("BranchOfficesSchedule.count") do
      post branch_offices_schedules_url, params: { branch_offices_schedule: { branch_office_id: @branch_offices_schedule.branch_office_id, schedule_id: @branch_offices_schedule.schedule_id } }
    end

    assert_redirected_to branch_offices_schedule_url(BranchOfficesSchedule.last)
  end

  test "should show branch_offices_schedule" do
    get branch_offices_schedule_url(@branch_offices_schedule)
    assert_response :success
  end

  test "should get edit" do
    get edit_branch_offices_schedule_url(@branch_offices_schedule)
    assert_response :success
  end

  test "should update branch_offices_schedule" do
    patch branch_offices_schedule_url(@branch_offices_schedule), params: { branch_offices_schedule: { branch_office_id: @branch_offices_schedule.branch_office_id, schedule_id: @branch_offices_schedule.schedule_id } }
    assert_redirected_to branch_offices_schedule_url(@branch_offices_schedule)
  end

  test "should destroy branch_offices_schedule" do
    assert_difference("BranchOfficesSchedule.count", -1) do
      delete branch_offices_schedule_url(@branch_offices_schedule)
    end

    assert_redirected_to branch_offices_schedules_url
  end
end
