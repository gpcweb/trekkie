class Lend < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum :status, {
    active: 'active',
    renewed: 'renewed',
    returned: 'returned'
  }, default: :active
end
