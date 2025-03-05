require 'rails_helper'

RSpec.describe 'Books', type: :request do
  let(:headers) do
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
  end

  describe 'GET /api/v1/books/:id/income' do
    let(:book) do
      create(:book, title: 'The End of Eternity')
    end
    let(:book_double) do
      double('book', id: book.id, title: book.title, author: book.author, income: 5)
    end

    before do
      allow(BookManagement::IncomeQuery).to receive(:call).and_return(book_double)
    end

    it 'returns http ok' do
      get "/api/v1/books/#{book.id}/income", headers: headers, params: { start_date: Date.today, end_date: Date.today }

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.keys).to include('id', 'title', 'author', 'income')
    end
  end
end
