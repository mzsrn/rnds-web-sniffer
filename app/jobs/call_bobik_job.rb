class CallBobikJob < ApplicationJob
  queue_as :default

  def perform(user_id, login, password)
    puts '>>>>>>>>>>>'
    puts '>>>>>>>>>>>'
    ActionCable.server.broadcast("bobik:#{user_id}", content: 'Start connecting from job')
    Bobik.new(user_id, login, password)
    puts '>>>>>>>>>>>'
  end
end
