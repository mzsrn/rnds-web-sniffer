class Bobik::Base

  def initialize collar
    @user = User.find(collar.user.id)
  end

end