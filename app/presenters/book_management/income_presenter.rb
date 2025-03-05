module BookManagement
  class IncomePresenter
    class << self
      def serialize_book_income(book_income)
        {
          id: book_income.id,
          title: book_income.title,
          author: book_income.author,
          income: book_income.income
        }
      end
    end
  end
end
