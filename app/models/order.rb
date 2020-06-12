# == Schema Information
#
# Table name: orders
#
#  id               :bigint           not null, primary key
#  address          :string
#  client_name      :string
#  delivery_service :string
#  line_items       :jsonb
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
end
