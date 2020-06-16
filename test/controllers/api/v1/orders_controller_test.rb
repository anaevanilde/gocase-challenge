require 'test_helper'

class Api::V1::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get orders by reference or client name" do
    order = orders(:first)
    get get_status_api_v1_orders_path, params: { reference: order.reference, page: { number: 1 } }
    assert_response :success
  end

  test "should list orders by purchase_channel" do
    order = orders(:first)
    get api_v1_orders_path, params: { purchase_channel: order.purchase_channel, status: order.status, page: { number: 1 } }
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post api_v1_orders_path,
      params: {
        order: {
          client_name: Faker::Name.name,
          delivery_service: ["Sedex", "Pax"].sample,
          purchase_channel: ["Site BR", "Site USA"].sample,
          address: Faker::Address.street_address,
          total_value: (Random.rand * 100).round(2),
          line_items_attributes: [
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
    end

    assert_response :created
  end
end
