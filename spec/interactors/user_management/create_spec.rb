require 'rails_helper'

describe UserManagement::Create do
  subject(:interactor) do
      described_class.call(params: params)
  end

  let(:params) do
    {
      first_name: 'Gabriel',
      last_name: 'Poblete',
      email: 'poblete.cuadra@live.cl',
      initial_balance: 5
    }
  end

  it 'is successful' do
    expect(interactor.success?).to be(true)
    expect(interactor.errors).to be_empty
  end

  it 'creates a user record' do
    expect { interactor }.to change { User.all.size }.by(1)
  end

  it 'creates an account record' do
    expect { interactor }.to change { Account.all.size }.by(1)
  end

  context 'when initial_balance is not provided' do
    let(:params) do
      {
        first_name: 'Gabriel',
        last_name: 'Poblete',
        email: 'poblete.cuadra@live.cl'
      }
    end
    let(:errors) do
      {
        account: [{ details: nil, message: "Initial balance must be present or greater than zero" }]
      }
    end

    it 'is not successful' do
      expect(interactor.success?).to be(false)
      expect(interactor.errors).to eq(errors)
    end

    it 'does not create a user record' do
      expect { interactor }.not_to change { User.all.size }
    end

    it 'does not create an account record' do
      expect { interactor }.not_to change { Account.all.size }
    end
  end
end
