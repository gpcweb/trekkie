require 'rails_helper'

describe BookManagement::Return do
  subject(:interactor) do
      described_class.call(book_id: book_id, user_id: user_id)
  end

  let(:book) { create(:book) }
  let(:book_id) { book.id }
  let(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:account) { create(:account, user_id: user_id, balance: 5) }
  let(:lend) { create(:lend, user_id: user_id, book_id: book_id) }

  before do
    book
    user
    lend
    account
  end

  it 'is successful' do
    expect(interactor.success?).to be(true)
    expect(interactor.errors).to be_empty
  end

  it 'updates the account balance' do
    expect {
      interactor
      account.reload
    }.to change { account.balance }.from(5).to(4)
  end

  it 'updates the lend status' do
    expect {
      interactor
      lend.reload
    }.to change { lend.status }.from('active').to('returned')
  end

  context 'when its unable to find the account' do
    let(:account) { nil }
    let(:errors) do
      {
        base: [{ details: nil, message: "Unable to find record" }]
      }
    end

    it 'is not successful' do
      expect(interactor.success?).to be(false)
      expect(interactor.errors).to eq(errors)
    end

    it 'does not updates the lend status' do
      expect {
        interactor
        lend.reload
      }.not_to change { lend.status }
    end
  end
end
