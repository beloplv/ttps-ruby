require "application_system_test_case"

class BranchOfficesTest < ApplicationSystemTestCase
  setup do
    @branch_office = branch_offices(:one)
  end

  test "visiting the index" do
    visit branch_offices_url
    assert_selector "h1", text: "Branch offices"
  end

  test "should create branch office" do
    visit branch_offices_url
    click_on "New branch office"

    fill_in "Address", with: @branch_office.address
    fill_in "Name", with: @branch_office.name
    fill_in "Phone", with: @branch_office.phone
    click_on "Create Branch office"

    assert_text "Branch office was successfully created"
    click_on "Back"
  end

  test "should update Branch office" do
    visit branch_office_url(@branch_office)
    click_on "Edit this branch office", match: :first

    fill_in "Address", with: @branch_office.address
    fill_in "Name", with: @branch_office.name
    fill_in "Phone", with: @branch_office.phone
    click_on "Update Branch office"

    assert_text "Branch office was successfully updated"
    click_on "Back"
  end

  test "should destroy Branch office" do
    visit branch_office_url(@branch_office)
    click_on "Destroy this branch office", match: :first

    assert_text "Branch office was successfully destroyed"
  end
end
