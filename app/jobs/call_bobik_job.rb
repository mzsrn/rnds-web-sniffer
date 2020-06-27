class CallBobikJob < ApplicationJob
  queue_as :default

  def perform user_id, credentials
    collar = Collar::Finam.new(User.find(user_id), credentials)
    bobik = Bobik::Finam.new(collar)
    bobik.fetch!
  end

end
