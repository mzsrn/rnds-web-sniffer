class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :brokers, dependent: :destroy
  has_many :accounts, through: :brokers, dependent: :destroy
  has_many :portfolios, through: :accounts, dependent: :destroy

  def tinkoff_accounts
    brokers.where(name: :tinkoff).take.try(:accounts) || []
  end

end
