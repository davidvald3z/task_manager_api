require 'rails_helper'

RSpec.describe Api::V1::MovementsController, type: :controller do
  let!(:branch) { create(:branch) }
  let!(:movement) { create(:movement, branch: branch, movement_type: 'I') }
  let!(:sales) { create_list(:movement, 3, movement_type: 'I', branch: branch) }
  let!(:expenses) { create_list(:movement, 3, movement_type: 'E', branch: branch) }

  describe "GET #index" do
    context "with sales type" do
      it "returns a list of sales movements" do
        get :index, params: { type: 'sales' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(4)
        expect(JSON.parse(response.body).first['movement_type']).to eq('I')
      end
    end

    context "with expenses type" do
      it "returns a list of expense movements" do
        get :index, params: { type: 'expenses' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(3)
        expect(JSON.parse(response.body).first['movement_type']).to eq('E')
      end
    end

    context "without type" do
      it "returns all movements" do
        get :index
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(7)  # Includes both sales and expenses
      end
    end
  end

  describe "GET #show" do
    it "returns a specific movement" do
      get :show, params: { id: movement.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(movement.id)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_attributes) do
        { movement_type: 'I', description: 'New sale', amount: 100, movement_date: '2024-09-05', branch_id: branch.id }
      end

      it "creates a new movement" do
        expect {
          post :create, params: valid_attributes
        }.to change(Movement, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['description']).to eq('New sale')
        expect(JSON.parse(response.body)['movement_date']).to eq('2024-09-05')
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) { { movement_type: '', description: '', amount: nil, movement_date: '' } }

      it "returns errors" do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        
        body = JSON.parse(response.body)
  
        expect(body).to have_key("description")
        expect(body["description"]).to include("can't be blank")
        
        expect(body).to have_key("branch")
        expect(body["branch"]).to include("must exist")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { description: 'Updated description', amount: 150, movement_date: '2024-09-06' } }

      it "updates the requested movement" do
        put :update, params: { id: movement.id, **new_attributes }
        movement.reload
        expect(movement.description).to eq('Updated description')
        expect(movement.amount).to eq(150)
        expect(movement.movement_date.to_s).to eq('2024-09-06')
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) { { description: '', amount: nil, movement_date: '' } }

      it "returns errors" do
        put :update, params: { id: movement.id, **invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the requested movement" do
      expect {
        delete :destroy, params: { id: movement.id }
      }.to change(Movement, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
