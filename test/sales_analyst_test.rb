require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'time'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < MiniTest::Test
  def test_if_it_exists
    sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices  => './data/invoices.csv'
    })

    assert_instance_of SalesAnalyst, sales_engine.analyst
  end

  def test_it_returns_all_merchants
    sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices  => './data/invoices.csv'
    })

    sales_analyst = sales_engine.analyst

    assert_equal 475, sales_analyst.total_merchants
  end

  def test_it_returns_all_items
    sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices  => './data/invoices.csv'
    })

    sales_analyst = sales_engine.analyst

    assert_equal 1367, sales_analyst.total_items
  end

  def test_that_it_returns_the_avg_item_per_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices  => './data/invoices.csv'
    })

    sales_analyst = sales_engine.analyst

    assert_equal 2.88, sales_analyst.average_items_per_merchant
  end

  def test_the_standard_deviation_avg_item_per_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices  => './data/invoices.csv'
    })

    sales_analyst = sales_engine.analyst

    actual = sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal 3.26, actual
  end

  def test_that_it_returns_the_merchants_that_sell_the_most_items
    sales_engine = SalesEngine.from_csv({
    :items     => './data/items.csv',
    :merchants => './data/merchants.csv',
    :invoices  => './data/invoices.csv'
  })

    sales_analyst = sales_engine.analyst

    assert_equal 475, sales_analyst.total_items_per_merchant.count
    assert_equal 52, sales_analyst.merchant_id_with_high_item_count.count
    assert_equal 52, sales_analyst.merchants_with_high_item_count.count
  end

  def test_the_avg_item_price_per_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices  => './data/invoices.csv'
    })

    sales_analyst = sales_engine.analyst

    assert_equal 64.7, sales_analyst.sum_of_merch_items_array(12334185)
    assert_equal 10.78, sales_analyst.average_item_price_for_merchant(12334185)
  end

  def test_it_makes_array_of_avg_item_prices
    sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices  => './data/invoices.csv'
    })

    sales_analyst = sales_engine.analyst

    assert_equal 475, sales_analyst.array_of_merchant_averages.count
    assert_equal 166391.91, sales_analyst.sum_of_averages
    assert_equal 350.29, sales_analyst.average_average_price_per_merchant
  end

  def test_if_it_returns_an_array_of_golden_items
    sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices  => './data/invoices.csv'
    })

    sales_analyst = sales_engine.analyst

    assert_equal 6155.85, sales_analyst.two_standard_devs_above
    assert sales_analyst.golden_items[0], Item
    assert_equal 5, sales_analyst.golden_items.count
  end

  def test_it_calculates_average_invoices_per_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices  => './data/invoices.csv'
    })

    sales_analyst = sales_engine.analyst

    assert_equal 4985, sales_analyst.total_invoices.length
    assert_equal 10.49, sales_analyst.average_invoices_per_merchant
  end

  def test_it_calculates_average_invoices_per_merchant_standard_deviation
    sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices  => './data/invoices.csv'
    })

    sales_analyst = sales_engine.analyst

    actual = sales_analyst.average_invoices_per_merchant_standard_deviation
    assert_equal 3.29, actual
  end

  def test_it_can_find_total_invoices_per_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices  => './data/invoices.csv'
    })

    sales_analyst = sales_engine.analyst

    assert_equal 475, sales_analyst.total_invoices_per_merchant.count
  end

  def test_it_can_calculate_two_standard_deviations
    sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices  => './data/invoices.csv'
    })

    sales_analyst = sales_engine.analyst

    assert_equal 6.58, sales_analyst.two_standard_deviations
  end

  def test_it_can_return_top_merchants_merchant_ids
    sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices  => './data/invoices.csv'
    })

    sales_analyst = sales_engine.analyst

    actual = sales_analyst.top_merchants_by_invoice_count_merchant_ids.count
    assert_equal 12, actual
  end

  def test_it_can_return_top_merchants
    sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices  => './data/invoices.csv'
    })

    sales_analyst = sales_engine.analyst

    assert_equal 12, sales_analyst.top_merchants_by_invoice_count.count
  end

  def test_it_can_return_bottom_merchants
    sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices  => './data/invoices.csv'
    })

    sales_analyst = sales_engine.analyst

    actual = sales_analyst.bottom_merchants_by_invoice_count_merchant_ids
    assert_instance_of Array, actual
    assert_equal 4, sales_analyst.bottom_merchants_by_invoice_count.count
  end

  def test_it_can_calculate_top_days_by_invoice_count
    sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices  => './data/invoices.csv'
    })

    sales_analyst = sales_engine.analyst

    expected = {"Saturday"=>729, "Friday"=>701, "Wednesday"=>741,
                "Monday"=>696, "Sunday"=>708, "Tuesday"=>692, "Thursday"=>718}
    assert_equal expected, sales_analyst.total_invoices_per_day_hash
    assert_equal 712, sales_analyst.average_invoices_per_day
    assert_equal 18.07, sales_analyst.standard_deviation_of_invoices_per_day
    assert_equal ["Wednesday"], sales_analyst.top_days_by_invoice_count
  end

  def test_it_can_calculate_precantage_based_on_status
    sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices  => './data/invoices.csv'
      })

    sales_analyst = sales_engine.analyst

    expected = {:pending=>1473, :shipped=>2839, :returned=>673}
    assert_equal expected, sales_analyst.invoice_status_hash
    assert_equal 29.55, sales_analyst.invoice_status(:pending)
    assert_equal 56.95, sales_analyst.invoice_status(:shipped)
    assert_equal 13.5, sales_analyst.invoice_status(:returned)
  end
end
