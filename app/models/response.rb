class Response

  attr_reader :success, :status, :title, :message, :path

  class << self

    def by_resource resource
      is_persisted = resource.persisted?
      if resource.save
        status = is_persisted ? :ok : :created
        Response.new(success=true, data=resource.attributes, title="Успешно", message="Сохранено", status=status)
      else
        Response.new(success=false, title="Не успешно", message=resource.errors.full_messages.join(", "), status=400)
      end
    end

  end

  def initialize success, data, title, message, status, path=nil, action=nil
    @success = success
    @title = title
    @message = message
    @path = path
    @action = action
    @data = data

    @status = status
  end

  def body
    {
      success: @success,
      title: @title,
      message: @message,
      path: @path,
      action: @action
    }
  end

end