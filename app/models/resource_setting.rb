class ResourceSetting < ApplicationRecord
  
  extend Enumerize

  self.inheritance_column = :foo

  has_one :portfolio
  belongs_to :user

  enumerize :type, in: [:finam, :tinkoff]

end
