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
  has_many :orders
end
