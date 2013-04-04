class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role? :superuser
      can :manage, :all
    elsif user.role? :admin
      can :manage, :all
      cannot :manage, User
    elsif user.role? :user
      can :read, :all
      can :create, Order
    else
      can :read, :all
      can :create, Order; cannot :read, Order
    end
  end
end
