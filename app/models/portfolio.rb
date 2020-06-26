class Portfolio < ApplicationRecord

  extend Enumerize
  
  ASYNC_TYPES = %w(finam)

  belongs_to :user
  enumerize :broker, in: %w(finam tinkoff), scope: true
  validates_uniqueness_of :broker, scope: :user_id

  def is_async_parsing?
    ASYNC_TYPES.include? type
  end


end
