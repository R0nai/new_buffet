class PaymentMethod < ApplicationRecord
  has_many :payments
  has_many :buffets, through: :payments
end
