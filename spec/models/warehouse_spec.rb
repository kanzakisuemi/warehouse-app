require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#válido?' do
    it 'falso quando nome está vázio' do
      warehouse = Warehouse.new(name: '', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Aeroporto, 600', cep: '72000-400', description: 'Galpão destinado à cargas do Rio')

      expect(warehouse).not_to be_valid
    end

    it 'falso quando código está vázio' do
      warehouse = Warehouse.new(name: 'Rio', code: '', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Aeroporto, 600', cep: '72000-400', description: 'Galpão destinado à cargas do Rio')

      expect(warehouse).not_to be_valid
    end

    it 'falso quando endereço está vázio' do
      warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: '', cep: '72000-400', description: 'Galpão destinado à cargas do Rio')

      expect(warehouse).not_to be_valid
    end

    it 'falso quando código é repetido' do
      Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Aeroporto, 600', cep: '72000-400', description: 'Galpão destinado à cargas do Rio')
      warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'SDU', city: 'Rio de Janeiro', area: 80_000, address: 'Avenida do Outro Aeroporto, 550', cep: '72000-730', description: 'Galpão destinado à outras cargas do Rio')
  
      expect(warehouse).not_to be_valid
    end

  end
end
