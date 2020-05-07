require 'test_helper'

class FoodDietsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @food_diet = food_diets(:one)
  end

  test "should get index" do
    get food_diets_url
    assert_response :success
  end

  test "should get new" do
    get new_food_diet_url
    assert_response :success
  end

  test "should create food_diet" do
    assert_difference('FoodDiet.count') do
      post food_diets_url, params: { food_diet: {  } }
    end

    assert_redirected_to food_diet_url(FoodDiet.last)
  end

  test "should show food_diet" do
    get food_diet_url(@food_diet)
    assert_response :success
  end

  test "should get edit" do
    get edit_food_diet_url(@food_diet)
    assert_response :success
  end

  test "should update food_diet" do
    patch food_diet_url(@food_diet), params: { food_diet: {  } }
    assert_redirected_to food_diet_url(@food_diet)
  end

  test "should destroy food_diet" do
    assert_difference('FoodDiet.count', -1) do
      delete food_diet_url(@food_diet)
    end

    assert_redirected_to food_diets_url
  end
end
