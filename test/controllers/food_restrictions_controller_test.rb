require 'test_helper'

class FoodRestrictionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @food_restriction = food_restrictions(:one)
  end

  test "should get index" do
    get food_restrictions_url
    assert_response :success
  end

  test "should get new" do
    get new_food_restriction_url
    assert_response :success
  end

  test "should create food_restriction" do
    assert_difference('FoodRestriction.count') do
      post food_restrictions_url, params: { food_restriction: {  } }
    end

    assert_redirected_to food_restriction_url(FoodRestriction.last)
  end

  test "should show food_restriction" do
    get food_restriction_url(@food_restriction)
    assert_response :success
  end

  test "should get edit" do
    get edit_food_restriction_url(@food_restriction)
    assert_response :success
  end

  test "should update food_restriction" do
    patch food_restriction_url(@food_restriction), params: { food_restriction: {  } }
    assert_redirected_to food_restriction_url(@food_restriction)
  end

  test "should destroy food_restriction" do
    assert_difference('FoodRestriction.count', -1) do
      delete food_restriction_url(@food_restriction)
    end

    assert_redirected_to food_restrictions_url
  end
end
