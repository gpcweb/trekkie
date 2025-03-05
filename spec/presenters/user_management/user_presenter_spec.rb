require 'rails_helper'

describe UserManagement::UserPresenter do
  let(:user) { create(:user) }

  describe '#serialize_user' do
    subject(:result) { described_class.serialize_user(user) }

    let(:expected_keys) do
      %i[id first_name last_name email]
    end

    it 'returns a hash' do
      expect(result).to be_a(Hash)
    end

    it 'returns a defined structure' do
      expect(result.keys).to eq(expected_keys)
    end

    it 'returns the correct data' do
      expect(result).to include(id: user.id)
    end
  end
end
