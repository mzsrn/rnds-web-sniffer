class Portfolio < ApplicationRecord

  extend Enumerize
  
  ASYNC_TYPES = %w(finam)

  belongs_to :user
  belongs_to :broker
  belongs_to :account

  enumerize :broker, in: %w(finam tinkoff), scope: true
  validates_uniqueness_of :broker, scope: :user_id

  def is_async_parsing?
    ASYNC_TYPES.include? type
  end


end
