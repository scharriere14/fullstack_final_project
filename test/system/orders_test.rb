require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "should create order" do
    visit orders_url
    click_on "New order"

    fill_in "Customer", with: @order.customer_id
    fill_in "Order", with: @order.order_id
    fill_in "Product", with: @order.product_id
    fill_in "Product name", with: @order.product_name
    fill_in "Tracking number", with: @order.tracking_number
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "should update Order" do
    visit order_url(@order)
    click_on "Edit this order", match: :first

    fill_in "Customer", with: @order.customer_id
    fill_in "Order", with: @order.order_id
    fill_in "Product", with: @order.product_id
    fill_in "Product name", with: @order.product_name
    fill_in "Tracking number", with: @order.tracking_number
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "should destroy Order" do
    visit order_url(@order)
    click_on "Destroy this order", match: :first

    assert_text "Order was successfully destroyed"
  end
end
