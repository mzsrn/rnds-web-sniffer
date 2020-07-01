class Account < ApplicationRecord
  
  extend Enumerize
  
  belongs_to :user
  belongs_to :broker

  has_many :balances, dependent: :destroy
  has_one :portfolio, dependent: :destroy
  
end
