class ActiveInteractionBase < ActiveInteraction::Base

  def result!
    if self.valid?
      self
    else
      self.errors
    end
  end

end