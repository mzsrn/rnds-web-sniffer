class Bobik::Base

  def initialize collar
    @user_id = collar.user.id
    @portfolio = collar.resource.portfolio || Portfolio.new(resource: collar.resource)
  end

end