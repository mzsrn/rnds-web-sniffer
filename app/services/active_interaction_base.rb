class ActiveInteractionBase < ActiveInteraction::Base

  def result!
    if self.errors.any?
      raise ExecuteError.new(self.errors.full_messages.join(', '))
    else
      self.result
    end
  end

end