class Ability
  include CanCan::Ability

  def initialize(user)
    # Guest
    unless user
      can :read, [Store, Category, Product, Order]
      can :create, [User, Order]
    else
      # Standard User
      can :create, Store
      can :read, User, :user_id => user.id

      if user.platform_administrator
        can :manage, :all
      end
    end
    #user ||= User.new

    #if user.platform_administrator
    #  can :manage, :all
    #elsif user
    #  can :read, User, :user_id => user.id
    #  can :create, Store
    #else
    #  cannot :read, User
    #  can :create, Order; cannot :read, Order
    #end
  end
end
