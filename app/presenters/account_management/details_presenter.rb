module AccountManagement
  class DetailsPresenter
    class << self
      def serialize_account_details(account_details)
        {
          id: account_details.id,
          user_id: account_details.user_id,
          balance: account_details.balance,
          borrowed_books: account_details.borrowed_books
        }
      end
    end
  end
end
