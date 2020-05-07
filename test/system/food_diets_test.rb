require "application_system_test_case"

class FoodDietsTest < ApplicationSystemTestCase
  setup do
    @food_diet = food_diets(:one)
  end

  test "visiting the index" do
    visit food_diets_url
    assert_selector "h1", text: "Food Diets"
  end

  test "creating a Food diet" do
    visit food_diets_url
    click_on "New Food Diet"

    click_on "Create Food diet"

    assert_text "Food diet was successfully created"
    click_on "Back"
  end

  test "updating a Food diet" do
    visit food_diets_url
    click_on "Edit", match: :first

    click_on "Update Food diet"

    assert_text "Food diet was successfully updated"
    click_on "Back"
  end

  test "destroying a Food diet" do
    visit food_diets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Food diet was successfully destroyed"
  end
end
