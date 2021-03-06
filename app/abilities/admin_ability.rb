class AdminAbility
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    return unless user.admin?
    can :get, :home
    delegation_rules
    camp_rules
    day_schedule_rules
    participant_rules
    messages_rules
  end

  def can(a, c, *args, &block)
    case c
    when Class
      klass = "Admin::#{c.name}Decorator".safe_constantize
      can(a, [c, klass].compact, *args, &block)
    else
      super
    end
  end

  def camp_rules
    can [:index, :show, :new, :edit, :create, :update, :dashboard], Camp
  end

  def delegation_rules
    can [:index, :new, :create, :edit, :update, :show], Delegation
    can :destroy, Delegation if user.superadmin?
  end

  def day_schedule_rules
    can [:edit, :update, :index], DaySchedule
  end

  def messages_rules
    return unless user.superadmin?
    can [:index, :new, :create], Message, user_id: user.id
  end

  def participant_rules
    can [:index, :edit, :update, :show], Participant
    can :destroy, Participant if user.superadmin?
  end
end
