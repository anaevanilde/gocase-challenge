class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get orders by reference or client name" do
    get get_status_api_v1_orders_path, params: { reference: "BR000005", page: { number: 1 } }
    assert_response :success
  end

  test "should list orders by purchase_channel" do
    get api_v1_orders_path, params: { purchase_channel: Order.first&.purchase_channel, status: Order.first&.status, page: { number: 1 } }
    assert_response :success
  end

  test "should create order" do
    post api_v1_orders_path
      {
        order: {
          name: Faker::Address.street_address,
          client_name: Faker::Name.name ,
          delivery_service: ["Sedex", "Pax"].sample,
          purchase_channel: ["Site BR", "Site USA"],
          total_value: (Random.rand * 100).round(2),
          line_items_attributes:[
            {
              sku: "case-my-best-friend",
              specifications: {
                model: "iPhone X",
                "case type": "Rose Leather"
              }
            },
            {
              sku: "powebank-sunshine",
              specifications: {
                capacity: "10000mah"
              }
            },
            {
              sku: "earphone-standard",
              specifications: {
                color: "white"
              }
            }
          ]
        }
      }

    assert_response :success
  end
end
