# == Schema Information
#
# Table name: orders
#
#  id               :bigint           not null, primary key
#  address          :string
#  client_name      :string
#  delivery_service :string
#  purchase_channel :string
#  reference        :string
#  status           :string           default("ready")
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
  include Referenceable

  belongs_to :batch, optional: true
  has_many :line_items

  accepts_nested_attributes_for :line_items

  validates_presence_of :address, :client_name, :delivery_service, :purchase_channel,
                        :delivery_service, :total_value

  enum status: {
    ready: 'ready', # A new order, ready to be produced
    production: 'production', # Waiting to be printed
    closing:  'closing', # Already produced, waiting to be sent
    sent: 'sent' # On the way to the client
   }

  scope :get_status_attributes, -> { select(:id, :reference, :status, :client_name) }
end
