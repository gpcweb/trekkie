require 'rails_helper'

describe BookManagement::Lend do
  subject(:interactor) do
      described_class.call(book_id: book_id, user_id: user_id)
  end

  let(:book) { create(:book) }
  let(:book_id) { book.id }
  let(:user) { create(:user) }
  let(:user_id) { user.id }

  it 'is successful' do
    expect(interactor.success?).to be(true)
    expect(interactor.errors).to be_empty
  end

  it 'creates a lend record' do
    expect { interactor }.to change { Lend.all.size }.by(1)
  end

  context 'when book_id does not exist' do
    let(:book_id) { 999 }
    let(:errors) do
      {
        book: [{ details: nil, message: "must exist" }]
      }
    end

    it 'is not successful' do
      expect(interactor.success?).to be(false)
      expect(interactor.errors).to eq(errors)
    end

    it 'does not createsa lend record' do
      expect { interactor }.not_to change { Lend.all.size }
    end
  end
end
