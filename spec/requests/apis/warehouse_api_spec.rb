require 'rails_helper'

describe 'warehouse api' do
  context 'GET /api/v1/warehouses/1' do
    it 'success' do
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Aeroporto, 600', cep: '72000-400', description: 'Galpão destinado à cargas do Rio')
      
      get "/api/v1/warehouses/#{warehouse.id}"

      json_response = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      
      expect(json_response["name"]).to eq warehouse.name
      expect(json_response["code"]).to eq warehouse.code
    end
    it 'fail if warehouse is not found' do
    
      get "/api/v1/warehouses/1"

      expect(response.status).to eq 404
    end
  end
  context 'GET /api/v1/warehouses' do
    it 'success' do
      w1 = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Aeroporto, 600', cep: '72000-400', description: 'Galpão destinado à cargas do Rio')
      w2 = Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Avenida do Aeroporto, 500', cep: '98000-500', description: 'Galpão destinado à cargas de Maceio')
      
      get '/api/v1/warehouses'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 2
      expect(json_response[0]['name']).to eq w1.name
      expect(json_response[1]['name']).to eq w2.name
    end
    it 'empty if there is no warehouse' do
      get '/api/v1/warehouses'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
    it 'and raise internal error' do
      allow(Warehouse).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/warehouses'

      expect(response.status).to eq 500
    end
  end
  context 'POST /api/v1/warehouses' do
    it 'success' do
      post '/api/v1/warehouses', params: { warehouse: { name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Aeroporto, 600', cep: '72000-400', description: 'Galpão destinado à cargas do Rio' } }

      expect(response.status).to eq 201
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq 'Rio'
      expect(json_response['code']).to eq 'SDU'
      expect(json_response['city']).to eq 'Rio de Janeiro'
      expect(json_response['area']).to eq 60_000
      expect(json_response['address']).to eq 'Avenida do Aeroporto, 600'
      expect(json_response['cep']).to eq '72000-400'
      expect(json_response['description']).to eq 'Galpão destinado à cargas do Rio'
    end
    it 'fail if parameters are not complete' do
      post '/api/v1/warehouses', params: { warehouse: { name: 'Rio', code: 'SDU' } }

      expect(response.status).to eq 412
      expect(response.body).to include 'Cidade não pode ficar em branco'
      expect(response.body).to include 'Área não pode ficar em branco'
      expect(response.body).to include 'Endereço não pode ficar em branco'
      expect(response.body).to include 'CEP não pode ficar em branco'
      expect(response.body).to include 'Descrição não pode ficar em branco'
    end
    it 'fail if theres an internal error' do
      allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)

      post '/api/v1/warehouses', params: { warehouse: { name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Aeroporto, 600', cep: '72000-400', description: 'Galpão destinado à cargas do Rio' } }

      expect(response.status).to eq 500
    end
  end
end
