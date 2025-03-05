class User < ApplicationRecord
  has_one :account
  has_many :borrows, class_name: 'Lend'

  validates :first_name, :last_name, :email, presence: true
end
