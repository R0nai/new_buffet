class Buffet < ApplicationRecord
  belongs_to :owner
  has_many :payments
  has_many :payment_methods, through: :payments
end
