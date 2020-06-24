class Collar::Tinkoff < Collar::Base

  attr_reader :token

  def initialize user, credentials
    raise ArgumentError.new("Формат credential - { token: 'MyToken' }") unless (credentials.respond_to?(:to_hash) && credentials.key?(:token))
    raise ArgumentError.new("Не указан токен") unless @token = credentials[:token]
    super(user)
  end

  def broker
    :tinkoff
  end

end
