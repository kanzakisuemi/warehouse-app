require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valido?' do
    it 'nome é obrigatório' do
      kylie = Supplier.create!(
        corporate_name: 'Kylie Cosmetics, LLC',
        brand_name: 'Kylie Cosmetics',
        employer_identification_number: '8895400053',
        address: 'Quinta avenida, 350',
        city: 'New York',
        cep: '10118011',
        email: 'customerservice@kyliecosmetic.com'
      )
      balm = ProductModel.new(name: '', weight: 50, width: 60, height: 10, depth: 40, sku: 'LCB-PNK-KYC009', supplier: kylie)

      result = balm.valid?

      expect(result).to eq false
    end
    it 'sku é obrigatório' do
      kylie = Supplier.create!(
        corporate_name: 'Kylie Cosmetics, LLC',
        brand_name: 'Kylie Cosmetics',
        employer_identification_number: '8895400053',
        address: 'Quinta avenida, 350',
        city: 'New York',
        cep: '10118011',
        email: 'customerservice@kyliecosmetic.com'
      )
      balm = ProductModel.new(name: 'lip and cheek glow balm', weight: 50, width: 60, height: 10, depth: 40, sku: '', supplier: kylie)

      result = balm.valid?

      expect(result).to eq false
    end
  end
end
