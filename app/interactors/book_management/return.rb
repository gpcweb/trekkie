module  BookManagement
  class Return < ApplicationInteractor
    attr_reader :book_id, :user_id

    def initialize(book_id:, user_id:)
      super
      @book_id = book_id
      @user_id = user_id
    end

    def execute
      ActiveRecord::Base.transaction do
        find_account && find_lend && update_lend && update_account_balance
      end
      self
    rescue ActiveRecord::RecordNotFound
      error(:base, message: 'Unable to find record')
      self
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved
      add_errors(@lend)
      self
    end

    private

    RETURN_FEE = 1

    def update_account_balance
      current_balance = @account.balance
      @account.update!(balance: current_balance - RETURN_FEE)
    end

    def find_account
      @account = ::Account.find_by!(user_id: user_id)
    end

    def find_lend
      @lend = ::Lend.find_by!(book_id: book_id, user_id: user_id, status: :active)
    end

    def update_lend
      @lend.update!(status: :returned)
    end
  end
end
