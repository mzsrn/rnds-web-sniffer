class ExecuteError < RuntimeError

  def initialize msg
    super(msg)
  end

end