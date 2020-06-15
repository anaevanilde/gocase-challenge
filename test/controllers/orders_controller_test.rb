class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get orders by reference or  client name" do
    get get_status_api_v1_orders_path(), params: { reference: "BR000005", page: { number: 1 } }
    assert_response :success
  end
end
