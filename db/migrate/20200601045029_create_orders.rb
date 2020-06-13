class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :reference
      t.string :client_name
      t.string :address
      t.string :delivery_service
      t.float :total_value
      t.string :status, default: 'ready'
      t.jsonb :line_items, array: true
      t.references :batch, index: true, foreign_key: true

      t.timestamps
    end
  end
end
