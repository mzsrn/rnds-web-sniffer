class Balance < ApplicationRecord
  
  extend Enumerize
  
  belongs_to :account
  
  enumerize :currency, in: %w(rub usd)

end
