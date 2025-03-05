require 'rails_helper'

describe BookManagement::IncomePresenter do
  let(:user1) { create(:user, email: 'poblete.cuadra@live.cl') }
  let(:user2) { create(:user, email: 'jacob.poblete@live.cl') }
  let(:book) do
    create(:book, title: 'The End Of Eternity')
  end

  let(:lends) do
    [
      create(:lend, book_id: book.id, user_id: user1.id, status: :active, created_at: Time.zone.now - 1.day),
      create(:lend, book_id: book.id, user_id: user2.id, status: :active, created_at: Time.zone.now - 1.day)
    ]
  end

  before do
    user1
    user2
    book
    lends
  end

  let(:record) { BookManagement::IncomeQuery.call(book_id: book.id, params: params) }
  let(:params) do
    {
      start_date: Time.zone.now - 2.days,
      end_date: Time.zone.now
    }
  end

  describe '#serialize_book_income' do
    subject(:result) { described_class.serialize_book_income(record) }

    let(:expected_keys) do
      %i[id title author income]
    end

    it 'returns a hash' do
      expect(result).to be_a(Hash)
    end

    it 'returns a defined structure' do
      expect(result.keys).to eq(expected_keys)
    end

    it 'returns the correct data' do
      expect(result).to include(id: book.id)
    end
  end
end
