module Referenceable extend ActiveSupport::Concern
  included do
    after_create :generate_reference
  end

  def generate_reference
    case self.class.name.downcase.to_sym
    when :batch then
      now = Time.current
      self.update(reference: now.month.to_s.rjust(2, "0") + now.year.to_s + "-" + self.id.to_s)
    when :order then
      self.update(reference: "BR" + id.to_s.rjust(6, "0"))
    end
  end
end
