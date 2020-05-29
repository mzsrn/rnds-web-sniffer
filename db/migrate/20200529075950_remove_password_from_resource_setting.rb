class RemovePasswordFromResourceSetting < ActiveRecord::Migration[6.0]
  def change
    remove_column :resource_settings, :password
  end
end
