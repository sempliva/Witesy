require 'test_helper'

class ShippingModeTest < ActiveSupport::TestCase
  test "should not save shipping mode with the same mode" do
    shipping_mode = ShippingMode.new(:mode=> "abc")
    shipping_mode.save
    shipping_mode2 = ShippingMode.new(:mode=> "abc")
    shipping_mode2.save
    assert_equal(1, ShippingMode.where("mode = 'abc'").count)
  end

  test "should not save shipping mode without mode" do
    shipping_mode = ShippingMode.new()
    assert !shipping_mode.save, "Saved the shipping_mode without mode"
  end

  # Tests relationship using fixture
  fixtures :shipping_modes

  def setup
    @shipping_mode = shipping_modes(:shipping_mode_one)
  end

  test "should save shipping mode" do
    assert @shipping_mode.save, "Shipping mode saved"
  end
end
