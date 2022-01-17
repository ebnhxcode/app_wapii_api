require 'rails_helper'

# Importante especificar el type:
# Para pruebas de integración se usa :request
RSpec.describe 'Health Endpoint', type: :request do

  # Se pueden agregar tantos describe como sean necesarios
  describe 'GET /health' do
    before { get '/health' }

    # Todas las pruebas comienzan con it
    it 'should return OK' do
      # La prueba como tal se realiza con expect, porque es lo que se espera al ejecutar la prueba
      payload = JSON.parse(response.body)
      expect( payload ).not_to be_empty
      expect( payload['api'] ).to eq('OK')
    end

    it 'should return status code 200' do
      expect( response ).to have_http_status(200)
    end
  end
  
end