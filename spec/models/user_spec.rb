require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#nome e email' do
    it 'exibe corretamente' do
      kendall = User.create!(email: 'kendall@jenner.com', password: 'pass123456', name: 'Kendall Jenner')

      result = kendall.name_and_email()

      expect(result).to eq 'Kendall Jenner - kendall@jenner.com'
    end
  end
end
