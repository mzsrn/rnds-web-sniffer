class Ability
  include CanCan::Ability
  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud
   
    if user.present?
      can :crud, Portfolio, user_id: user.id
    end

  end
end
