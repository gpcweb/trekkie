module Api
  module V1
    class BooksController < ApiController

      def lend
        result = BookManagement::Lend.call(book_id: params[:id], user_id: params[:user_id])

        if result.success?
          head :created
        else
          render json: { errors: result.errros }, status: :bad_requested
        end
      end

      def return
        result = BookManagement::Return.call(book_id: params[:id], user_id: params[:user_id])

        if result.success?
          head :ok
        else
          render json: { errors: result.errros }, status: :bad_requested
        end
      end

      def income
        book_income_details = BookManagement::IncomeQuery.call(book_id: params[:id], params: params)
        render json: serialize_book_income(book_income_details), status: :ok
      end

      private


      def serialize_book_income(book_income)
        BookManagement::IncomePresenter.serialize_book_income(book_income)
      end
    end
  end
end
