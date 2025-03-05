require 'rails_helper'

describe BookManagement::IncomeQuery do
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

  let(:record) { described_class.call(book_id: book.id, params: params) }
  let(:params) do
    {
      start_date: Time.zone.now - 2.days,
      end_date: Time.zone.now
    }
  end

  it 'returns the correct data' do
    expect(record.id).to eq(book.id)
    expect(record.title).to eq(book.title)
    expect(record.income).to eq(2)
  end
end
