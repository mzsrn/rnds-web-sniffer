class AddUserReferenceToResourceSetting < ActiveRecord::Migration[6.0]
  def change
    add_reference :resource_settings, :user
  end
end
