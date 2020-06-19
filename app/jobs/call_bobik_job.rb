class CallBobikJob < ApplicationJob
  queue_as :default

  def perform *args
    @user_id = args[0]
    @resource = args[1]
    @params = args[2]
    collar = get_collar
    return collar.errors unless collar.errors.empty?

    ActionCable.server.broadcast("bobik:#{@user_id}", content: 'Start connecting from job')
    Bobik::Tinkoff.new(collar)
  end

  private 

  def get_collar
    Collar::Tinkoff.new(@user_id, @resource.id, {token: @params["token"]})
  end

end
