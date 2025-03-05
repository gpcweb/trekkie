require 'rails_helper'

describe AccountManagement::DetailsQuery do
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
      status = i == 3 ? 'returned' : 'active'
      due_date = Time.zone.now + (1 + i).days
      create(:lend, book_id: book.id, user_id: user.id, status: status, due_date: due_date)
    end
  end

  before do
    user
    account
    books
    lends
  end

  let(:record) { described_class.call(user_id: user.id) }

  it 'returns the correct data' do
    expect(record.id).to eq(account.id)
    expect(record.balance).to eq(account.balance)
    expect(record.borrowed_books).to match_array([
        { 'user_id' => user.id, 'title' => 'Foundation', 'author' => 'Isaac Asimov', 'due_date' => (Date.today + 1.day).to_s },
        { 'user_id' => user.id, 'title' => 'The End Of Eternity', 'author' => 'Isaac Asimov', 'due_date' => (Date.today + 2.days).to_s },
        { 'user_id' => user.id, 'title' => 'The God Themselfs', 'author' => 'Isaac Asimov', 'due_date' => (Date.today + 3.days).to_s }
      ]
    )
  end
end
