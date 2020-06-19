class Portfolio < ApplicationRecord

  extend Enumerize
  
  ASYNC_TYPES = %w(finam)

  belongs_to :user
  enumerize :broker, in: %w(finam tinkoff)

  def is_async_parsing?
    ASYNC_TYPES.include? type
  end


end
