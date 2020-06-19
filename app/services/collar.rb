class Collar

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

  class Finam < Collar
  
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

  class Tinkoff < Collar
    attr_reader :token

    def initialize user, credentials
      raise ArgumentError.new("Не указан токен") unless @token = credentials[:token]
      super(user)
    end

    def broker
      :tinkoff
    end

  end
  
end

