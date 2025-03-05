module UserManagement
  class Create < ApplicationInteractor
    attr_reader :user, :params

    def initialize(params:)
      super
      @params = params
    end

    def execute
      return invalid_balance_error unless valid_initial_balance?

      ActiveRecord::Base.transaction do
        create_user && create_account
      end
      self
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved
      add_errors(@user)
      self
    end

    private

    def valid_initial_balance?
      params[:initial_balance].present? && params[:initial_balance].to_f > 0
    end

    def invalid_balance_error
      error(:account, message: 'Initial balance must be present or greater than zero')
      self
    end

    def create_user
      @user = User.new(
        first_name: params[:first_name],
        last_name: params[:last_name],
        email: params[:email]
      )

      @user.save!
    end

    def create_account
      account = Account.new(
        balance: params[:initial_balance].to_f,
        user_id: @user.id
      )

      account.save!
    end
  end
end
