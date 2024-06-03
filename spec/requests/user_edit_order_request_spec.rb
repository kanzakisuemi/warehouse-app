require 'rails_helper'

describe 'Usuário edita pedido' do
  it 'e deve estar autenticado' do
    julia = User.create!(email: 'kanzaki@myself.com', name: 'Julia Kanzaki', password: 'password123')
    pedro = User.create!(email: 'pedro@apostolos.com', name: 'Pedro Pedra', password: 'password123')
    warehouse_los = Warehouse.create(
      name: 'Los Angeles Airport',
      code: 'LOS',
      city: 'Los Angeles',
      area: 50_000,
      address: 'Avenida do Aeroporto, 500',
      cep: '98000-500',
      description: 'Galpão destinado à cargas importadas internacionalmente para Los Angeles'
    )
    kylie = Supplier.create!(
      corporate_name: 'Kylie Cosmetics, LLC',
      brand_name: 'Kylie Cosmetics',
      employer_identification_number: '8895400053',
      address: 'Quinta avenida, 350',
      city: 'New York',
      cep: '10118011',
      email: 'customerservice@kyliecosmetic.com'
    )
    order = Order.create!(warehouse: warehouse_los, supplier: kylie, user: julia, estimated_delivery_date: 11.days.from_now)

    login_as(pedro)
    patch order_path(order.id), params: { order: { warehouse_id: warehouse_los.id, supplier_id: kylie.id, estimated_delivery_date: 10.days.from_now } }

    expect(response).to redirect_to root_path
  end
end
