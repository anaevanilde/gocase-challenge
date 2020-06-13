class AddPurchaseChannelToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :purchase_channel, :string
  end
end
