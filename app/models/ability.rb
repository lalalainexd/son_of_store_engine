class Ability
  include CanCan::Ability
  
  def initialize(user)
    if user
      # logged in user
      if user.role? #create this method in user model
        # admin user
      end
    else
      # non-logged in user
    end
  end
end