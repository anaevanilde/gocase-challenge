# == Schema Information
#
# Table name: batches
#
#  id               :bigint           not null, primary key
#  purchase_channel :string
#  reference        :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Batch < ApplicationRecord
  include Referenceable

  has_many :orders

  after_create :associate_orders

  private
    def associate_orders
      included_orders = Order.where(purchase_channel: purchase_channel).update_all(batch_id: self.id)

      return true if included_orders > 0

      @errors = ActiveModel::Errors.new(self)
      errors.add(:purchase_channel, message: "can't find orders to create a batch")
      raise ActiveRecord::Rollback and return false
    end

end
