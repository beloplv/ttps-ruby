require "application_system_test_case"

class TurnsTest < ApplicationSystemTestCase
  setup do
    @turn = turns(:one)
  end

  test "visiting the index" do
    visit turns_url
    assert_selector "h1", text: "Turns"
  end

  test "should create turn" do
    visit turns_url
    click_on "New turn"

    fill_in "Date", with: @turn.date
    fill_in "Hour", with: @turn.hour
    fill_in "Motive", with: @turn.motive
    fill_in "Result", with: @turn.result
    fill_in "Status", with: @turn.status
    click_on "Create Turn"

    assert_text "Turn was successfully created"
    click_on "Back"
  end

  test "should update Turn" do
    visit turn_url(@turn)
    click_on "Edit this turn", match: :first

    fill_in "Date", with: @turn.date
    fill_in "Hour", with: @turn.hour
    fill_in "Motive", with: @turn.motive
    fill_in "Result", with: @turn.result
    fill_in "Status", with: @turn.status
    click_on "Update Turn"

    assert_text "Turn was successfully updated"
    click_on "Back"
  end

  test "should destroy Turn" do
    visit turn_url(@turn)
    click_on "Destroy this turn", match: :first

    assert_text "Turn was successfully destroyed"
  end
end
