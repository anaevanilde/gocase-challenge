class CreateLineItems < ActiveRecord::Migration[6.0]
  def change
    create_table :line_items do |t|
      t.string :sku
      t.jsonb :specifications
      t.references :order, index: true, foreign_key: true

      t.timestamps
    end
  end
end
