module UserManagement
  class UserPresenter
    class << self
      def serialize_user(user)
        {
          id: user.id,
          first_name: user.first_name,
          last_name: user.last_name,
          email: user.email
        }
      end
    end
  end
end
