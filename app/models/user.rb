class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: { maximum: 8 }
  validates :email, presence: true, uniqueness: true
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_one_attached :picture
end
