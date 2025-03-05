require 'rails_helper'

describe AccountManagement::DetailsPresenter do
  let(:user) { create(:user) }
  let(:account) { create(:account, balance: 5, user_id: user.id)}
  let(:books) do
    [
      create(:book),
      create(:book, title: 'The End Of Eternity'),
      create(:book, title: 'The God Themselfs'),
      create(:book, title: 'I, robot')
    ]
  end
  let(:lends) do
    books.map.with_index do |book, i|
      due_date = Time.zone.now + (1 + i).days
      create(:lend, book_id: book.id, user_id: user.id, status: :active, due_date: due_date)
    end
  end

  before do
    user
    account
    books
    lends
  end

  let(:record) { AccountManagement::DetailsQuery.call(user_id: user.id) }

  describe '#serialize_account_details' do
    subject(:result) { described_class.serialize_account_details(record) }

    let(:expected_keys) do
      %i[id user_id balance borrowed_books]
    end

    it 'returns a hash' do
      expect(result).to be_a(Hash)
    end

    it 'returns a defined structure' do
      expect(result.keys).to eq(expected_keys)
    end

    it 'returns the correct data' do
      expect(result).to include(id: account.id)
    end
  end
end
