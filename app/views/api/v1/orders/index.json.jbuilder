json.orders @orders

json.links do
  json.pages! @orders, url: get_status_api_v1_orders_path, query_parameters: { referece: params[:referece], client_name: params[:client_name] }
end
