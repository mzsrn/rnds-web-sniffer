class Collar

  attr_reader :user, :resource
  attr_reader :errors
  attr_reader :type

  def initialize user_id, resource_setting_id
    @errors = []
    @user = User.find(user_id)
    @resource = ResourceSetting.find(resource_setting_id)
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
  
    def initialize user_id, resource_setting_id, options
      raise ArgumentError "Не указан логин" unless @login = options[:login]
      raise ArgumentError "Не указан пароль" unless @password = options[:password]
      super(user_id, resource_setting_id)
    end

    def type
      :finam
    end
  end

  class Tinkoff < Collar
    attr_reader :token

    def initialize user_id, resource_setting_id, options
      raise ArgumentError "Не указан токен" unless @token = options[:token]
      super(user_id, resource_setting_id)
    end

    def type
      :tinkoff
    end

  end
  
end

