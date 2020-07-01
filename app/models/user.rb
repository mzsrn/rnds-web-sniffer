class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :brokers, dependent: :destroy
  has_many :accounts, through: :brokers, dependent: :destroy
  has_many :portfolios, through: :accounts, dependent: :destroy
  
end
