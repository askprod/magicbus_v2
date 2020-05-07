require "application_system_test_case"

class FoodRestrictionsTest < ApplicationSystemTestCase
  setup do
    @food_restriction = food_restrictions(:one)
  end

  test "visiting the index" do
    visit food_restrictions_url
    assert_selector "h1", text: "Food Restrictions"
  end

  test "creating a Food restriction" do
    visit food_restrictions_url
    click_on "New Food Restriction"

    click_on "Create Food restriction"

    assert_text "Food restriction was successfully created"
    click_on "Back"
  end

  test "updating a Food restriction" do
    visit food_restrictions_url
    click_on "Edit", match: :first

    click_on "Update Food restriction"

    assert_text "Food restriction was successfully updated"
    click_on "Back"
  end

  test "destroying a Food restriction" do
    visit food_restrictions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Food restriction was successfully destroyed"
  end
end
