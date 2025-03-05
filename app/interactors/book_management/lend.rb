module  BookManagement
  class Lend < ApplicationInteractor
    attr_reader :book_id, :user_id

    def initialize(book_id:, user_id:)
      super
      @book_id = book_id
      @user_id = user_id
    end

    def execute
      ActiveRecord::Base.transaction do
        create_lend
      end
      self
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved
      add_errors(@lend)
      self
    end

    private

    def create_lend
      @lend = ::Lend.new(
        book_id: book_id,
        user_id: user_id,
        due_date: Time.zone.now + 21.days,
        status: :active
      )

      @lend.save!
    end
  end
end
