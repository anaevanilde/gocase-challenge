class RemoveLineItemsFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :line_items
  end
end
