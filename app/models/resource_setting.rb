class ResourceSetting < ApplicationRecord
  
  extend Enumerize

  self.inheritance_column = :foo

  has_one :portfolio
  belongs_to :user

  enumerize :type, in: I18n.t('enumerize.resource_setting.type').keys

end
