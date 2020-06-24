class Collar::Base

  attr_reader :user, :errors, :broker

  def initialize user
    @errors = []
    @user = user
  rescue Exception => e
    add_error e
  end

  private 

  def add_error e
    if e.respond_to? :errors
      @errors << e.errors.full_messages
    else
      @errors << e.message
    end
  end

end

