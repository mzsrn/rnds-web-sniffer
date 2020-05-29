class ResourceSetting < ApplicationRecord
  self.inheritance_column = :foo

  belongs_to :user
end
