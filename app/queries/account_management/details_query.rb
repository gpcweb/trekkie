module AccountManagement
  class DetailsQuery
    class << self
      def call(user_id:)
        return Account.none if user_id.blank?

        Account.joins(borrowed_books_join, books_join)
               .where(user_id: user_id)
               .select(*fields)
               .group('accounts.id').first
      end

      private

      def borrowed_books_join
        <<-SQL.squish
          LEFT JOIN lends on lends.user_id = accounts.user_id AND lends.status = 'active'
        SQL
      end

      def books_join
        <<-SQL.squish
          LEFT JOIN books on books.id = lends.book_id
        SQL
      end

      def fields
        [
          'accounts.id',
          'accounts.user_id',
          'accounts.balance',
          borrowed_books_details
        ]
      end

      def borrowed_books_details
        <<~SQL.squish
          COALESCE(
            jsonb_agg(
              DISTINCT jsonb_build_object(
                        'user_id', lends.user_id,
                        'due_date', lends.due_date::date,
                        'title', books.title,
                        'author', books.author)
            ) FILTER (WHERE lends.user_id IS NOT NULL), '[]'::jsonb) AS borrowed_books
        SQL
      end
    end
  end
end
