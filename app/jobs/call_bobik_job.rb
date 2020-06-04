class CallBobikJob < ApplicationJob
  queue_as :default

  def perform(user_id, resource_setting_id, login, password)
    ActionCable.server.broadcast("bobik:#{user_id}", content: 'Start connecting from job')
    Bobik.new(user_id, resource_setting_id, login, password)
  end
end
