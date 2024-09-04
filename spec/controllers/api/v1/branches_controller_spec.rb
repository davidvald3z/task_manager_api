require 'rails_helper'

RSpec.describe Api::V1::BranchesController, type: :controller do
  # Utiliza FactoryBot para generar datos de prueba
  let!(:branch) { create(:branch) }  # Asume que tienes una fábrica para `Branch`
  let(:valid_attributes) { { name: 'New Branch', address: '123 Main St', city: 'Metropolis', state: 'NY', zip_code: '12345' } }
  let(:invalid_attributes) { { name: '', address: '', city: '', state: '', zip_code: '' } }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful  # Espera un código de estado 200
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)  # Verifica que la respuesta sea un array
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: branch.to_param }
      expect(response).to be_successful  # Espera un código de estado 200
      expect(JSON.parse(response.body)['id']).to eq(branch.id)  # Verifica que la respuesta tenga el ID correcto
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Branch' do
        expect {
          post :create, params: valid_attributes
        }.to change(Branch, :count).by(1)
      end

      it 'renders a JSON response with the new branch' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['name']).to eq('New Branch')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new branch' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['name']).to include("can't be blank")
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'Updated Branch' } }

      it 'updates the requested branch' do
        put :update, params: { id: branch.to_param, **new_attributes }
        branch.reload
        expect(branch.name).to eq('Updated Branch')
      end

      it 'renders a JSON response with the branch' do
        put :update, params: { id: branch.to_param, **new_attributes }
        expect(response).to be_successful
        expect(JSON.parse(response.body)['name']).to eq('Updated Branch')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the branch' do
        put :update, params: { id: branch.to_param, **invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['name']).to include("can't be blank")
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested branch' do
      expect {
        delete :destroy, params: { id: branch.to_param }
      }.to change(Branch, :count).by(-1)
    end

    it 'renders a JSON response with no content' do
      delete :destroy, params: { id: branch.to_param }
      expect(response).to have_http_status(:no_content)
    end
  end
end
