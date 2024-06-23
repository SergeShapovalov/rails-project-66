class User < ApplicationRecord
  has_many :repositories

  validates :email, presence: true, uniqueness: true
end
