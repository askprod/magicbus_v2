require "application_system_test_case"

class TripQuotationsTest < ApplicationSystemTestCase
  setup do
    @trip_quotation = trip_quotations(:one)
  end

  test "visiting the index" do
    visit trip_quotations_url
    assert_selector "h1", text: "Trip Quotations"
  end

  test "creating a Trip quotation" do
    visit trip_quotations_url
    click_on "New Trip Quotation"

    fill_in "Message", with: @trip_quotation.message
    click_on "Create Trip quotation"

    assert_text "Trip quotation was successfully created"
    click_on "Back"
  end

  test "updating a Trip quotation" do
    visit trip_quotations_url
    click_on "Edit", match: :first

    fill_in "Message", with: @trip_quotation.message
    click_on "Update Trip quotation"

    assert_text "Trip quotation was successfully updated"
    click_on "Back"
  end

  test "destroying a Trip quotation" do
    visit trip_quotations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trip quotation was successfully destroyed"
  end
end
