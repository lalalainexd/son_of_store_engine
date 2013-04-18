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
      can :manage, Store do | store |
        store.users.include?(user)
      end

      can :manage, User, :id => user.id

      if user.platform_administrator
        can :manage, :all
      end
    end
  end
end
