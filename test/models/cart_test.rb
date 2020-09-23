require 'test_helper'

class CartTest < ActiveSupport::TestCase

  test "Cart should belong to a user" do
    cart_user = carts(:default)
    cart_no_user = carts(:no_user)
    
    assert_equal true, cart_user.valid?
    assert_equal false, cart_no_user.valid?
  end

  test "Cart should be full is 8 travellers" do
    cart = carts(:default)
    full_cart = carts(:full)

    assert_equal false, cart.is_full?
    # Thanks to this ^ I fixed my first issue: it was returning nil instead of false! Changed in my model :)
    assert_equal true, full_cart.is_full?
  end

end
