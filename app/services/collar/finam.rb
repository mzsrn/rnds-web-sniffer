class Collar::Finam < Collar::Base
  
  attr_reader :login, :password
  
  def initialize user, credentials
    raise ArgumentError.new("Не указан логин") unless @login = credentials[:login]
    raise ArgumentError.new("Не указан пароль") unless @password = credentials[:password]
    super(user)
  end

  def broker
    :finam
  end

end
