require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe '#presence' do
    it 'of quantity' do
      order_item = OrderItem.new(quantity: nil)

      order_item.valid?
      result = order_item.errors.include?(:quantity)

      expect(result).to be true
    end
  end
end
