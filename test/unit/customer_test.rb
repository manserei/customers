require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  test "#full_name should return the full name" do
    @customer = Customer.new(:first_name => "Hans", :last_name => "Mans")
    assert_equal 'Mans, Hans', @customer.full_name
  end
end
