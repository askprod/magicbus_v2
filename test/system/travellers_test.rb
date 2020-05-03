require "application_system_test_case"

class TravellersTest < ApplicationSystemTestCase
  setup do
    @traveller = travellers(:one)
  end

  test "visiting the index" do
    visit travellers_url
    assert_selector "h1", text: "Travellers"
  end

  test "creating a Traveller" do
    visit travellers_url
    click_on "New Traveller"

    click_on "Create Traveller"

    assert_text "Traveller was successfully created"
    click_on "Back"
  end

  test "updating a Traveller" do
    visit travellers_url
    click_on "Edit", match: :first

    click_on "Update Traveller"

    assert_text "Traveller was successfully updated"
    click_on "Back"
  end

  test "destroying a Traveller" do
    visit travellers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Traveller was successfully destroyed"
  end
end
