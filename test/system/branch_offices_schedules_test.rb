require "application_system_test_case"

class BranchOfficesSchedulesTest < ApplicationSystemTestCase
  setup do
    @branch_offices_schedule = branch_offices_schedules(:one)
  end

  test "visiting the index" do
    visit branch_offices_schedules_url
    assert_selector "h1", text: "Branch offices schedules"
  end

  test "should create branch offices schedule" do
    visit branch_offices_schedules_url
    click_on "New branch offices schedule"

    fill_in "Branch office", with: @branch_offices_schedule.branch_office_id
    fill_in "Schedule", with: @branch_offices_schedule.schedule_id
    click_on "Create Branch offices schedule"

    assert_text "Branch offices schedule was successfully created"
    click_on "Back"
  end

  test "should update Branch offices schedule" do
    visit branch_offices_schedule_url(@branch_offices_schedule)
    click_on "Edit this branch offices schedule", match: :first

    fill_in "Branch office", with: @branch_offices_schedule.branch_office_id
    fill_in "Schedule", with: @branch_offices_schedule.schedule_id
    click_on "Update Branch offices schedule"

    assert_text "Branch offices schedule was successfully updated"
    click_on "Back"
  end

  test "should destroy Branch offices schedule" do
    visit branch_offices_schedule_url(@branch_offices_schedule)
    click_on "Destroy this branch offices schedule", match: :first

    assert_text "Branch offices schedule was successfully destroyed"
  end
end
