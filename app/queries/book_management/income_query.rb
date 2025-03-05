module BookManagement
  class IncomeQuery
    class << self
      def call(book_id:, params:)
        return Book.none if book_id.blank?

        Book.joins(lend_books_join)
            .where(books: { id: book_id })
            .where(lends: { created_at: params[:start_date]..params[:end_date] })
            .select(*fields)
            .group('books.id').first
      end

      private

      def lend_books_join
        <<-SQL.squish
          LEFT JOIN lends ON lends.book_id = books.id AND lends.status = 'active'
        SQL
      end

      RETURN_FEE = 1

      def fields
        [
          'books.id',
          'books.title',
          'books.author',
          "COUNT(lends.book_id) * #{RETURN_FEE} AS income"
        ]
      end
    end
  end
end
