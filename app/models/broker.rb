class Broker < ApplicationRecord
  
  extend Enumerize
  
  has_many :accounts, dependent: :destroy
  has_many :portfolios, through: :accounts, dependent: :destroy
  
  belongs_to :user
  
  enumerize :name, in: %w(tinkoff finam)

end
