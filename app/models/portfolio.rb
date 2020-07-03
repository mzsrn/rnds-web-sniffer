class Portfolio < ApplicationRecord

  extend Enumerize
  
  ASYNC_TYPES = %w(finam)

  belongs_to :user
  belongs_to :broker
  belongs_to :account

  def is_async_parsing?
    ASYNC_TYPES.include? type
  end


end
