require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:headers) do
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
  end

  describe 'POST /api/v1/users' do
    let(:user) do
      create(:user)
    end
    let(:user_double) do
      instance_double(UserManagement::Create,
        success?: true, user: user)
    end
    let(:valid_params) do
      {
        user: {
          first_name: 'Gabriel',
          last_name: 'Poblete',
          email: 'poblete.cuadra@live.cl',
          initial_balance: 5
        }
      }
    end

    before do
      allow(UserManagement::Create).to receive(:call).and_return(user_double)
    end

    it 'returns http created' do
      post '/api/v1/users', headers: headers, params: valid_params.to_json

      expect(response).to have_http_status(:created)
      expect(response.parsed_body.keys).to include('id', 'email')
    end
  end

  describe 'GET /api/v1/users/:id/account' do
    let(:user) do
      create(:user)
    end
    let(:account_double) do
      double('account', id: 1, user_id: user.id, balance: 5, borrowed_books: [])
    end

    before do
      allow(AccountManagement::DetailsQuery).to receive(:call).and_return(account_double)
    end

    it 'returns http ok' do
      get "/api/v1/users/#{user.id}/account", headers: headers

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.keys).to include('id', 'user_id', 'balance', 'borrowed_books')
    end
  end
end
