require 'test_helper'

class TripQuotationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trip_quotation = trip_quotations(:one)
  end

  test "should get index" do
    get trip_quotations_url
    assert_response :success
  end

  test "should get new" do
    get new_trip_quotation_url
    assert_response :success
  end

  test "should create trip_quotation" do
    assert_difference('TripQuotation.count') do
      post trip_quotations_url, params: { trip_quotation: { message: @trip_quotation.message } }
    end

    assert_redirected_to trip_quotation_url(TripQuotation.last)
  end

  test "should show trip_quotation" do
    get trip_quotation_url(@trip_quotation)
    assert_response :success
  end

  test "should get edit" do
    get edit_trip_quotation_url(@trip_quotation)
    assert_response :success
  end

  test "should update trip_quotation" do
    patch trip_quotation_url(@trip_quotation), params: { trip_quotation: { message: @trip_quotation.message } }
    assert_redirected_to trip_quotation_url(@trip_quotation)
  end

  test "should destroy trip_quotation" do
    assert_difference('TripQuotation.count', -1) do
      delete trip_quotation_url(@trip_quotation)
    end

    assert_redirected_to trip_quotations_url
  end
end
