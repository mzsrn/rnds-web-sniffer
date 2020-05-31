class ResourceSetting < ApplicationRecord
  self.inheritance_column = :foo

  has_one :portfolio
  belongs_to :user
end
