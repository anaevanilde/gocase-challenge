# == Schema Information
#
# Table name: orders
#
#  id               :bigint           not null, primary key
#  address          :string
#  client_name      :string
#  delivery_service :string
#  line_items       :jsonb            is an Array
#  purchase_channel :string
#  reference        :string
#  status           :string
#  total_value      :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  batch_id         :bigint
#
# Indexes
#
#  index_orders_on_batch_id  (batch_id)
#
# Foreign Keys
#
#  fk_rails_...  (batch_id => batches.id)
#
class Order < ApplicationRecord
  belongs_to :batch, optional: true

  enum status: {
    ready: 'ready', # A new order, ready to be produced
    production: 'production', # Waiting to be printed
    closing:  'closing', # Already produced, waiting to be sent
    sent: 'sent' # On the way to the client
   }

  scope :get_status_attributes, -> { select(:id, :reference, :status, :client_name) }
end
