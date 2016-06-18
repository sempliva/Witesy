class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.role? :admin and user.confirmed_email == true
  end

  def show?
    scope.where(:id => record.id).exists? and
          (user.role? :admin and user.confirmed_email == true)
  end

  def create?
    user.role? :admin and user.confirmed_email == true
  end

  def new?
    create?
  end

  def update?
    user.role? :admin and user.confirmed_email == true
  end

  def edit?
    update?
  end

  def destroy?
    user.role? :admin and user.confirmed_email == true
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
