require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'time'
require './lib/customer'

class CustomerTest < Minitest::Test
  def test_that_it_exists
    c = Customer.new({
      id: 6,
      first_name: "Joan",
      last_name: "Clarke",
      created_at: Time.now,
      updated_at: Time.now
    })

    assert_instance_of Customer, c
  end

  def test_the_attributes
    c = Customer.new({
      id: 6,
      first_name: "Joan",
      last_name: "Clarke",
      created_at: Time.now,
      updated_at: Time.now
    })

    assert_equal 6, c.id
    assert_equal "Joan", c.first_name
    assert_equal "Clarke", c.last_name
  end

  def test_the_create_updated_time_stamps
    c = Customer.new({
      id: 6,
      first_name: "Joan",
      last_name: "Clarke",
      created_at: Time.now,
      updated_at: Time.now
    })

    assert_instance_of Time, c.created_at
    assert_instance_of Time, c.updated_at
  end

end
