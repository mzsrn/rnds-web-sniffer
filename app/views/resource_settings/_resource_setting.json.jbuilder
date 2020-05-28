json.extract! resource_setting, :id, :login, :password, :type, :created_at, :updated_at
json.url resource_setting_url(resource_setting, format: :json)
