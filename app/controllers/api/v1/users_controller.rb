module Api
  module V1
    class UsersController < ApiController
      def create
        result = UserManagement::Create.call(params: user_params)

        if result.success?
          render json: serialize_user(result.user), status: :created
        else
          render json: { errors: result.errors }, status: :bad_request
        end
      end

      def account
        account_details = AccountManagement::DetailsQuery.call(user_id: params[:id])
        render json: serialize_account_details(account_details), status: :ok
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :initial_balance)
      end

      def serialize_user(user)
        UserManagement::UserPresenter.serialize_user(user)
      end

      def serialize_account_details(account_details)
        AccountManagement::DetailsPresenter.serialize_account_details(account_details)
      end
    end
  end
end
