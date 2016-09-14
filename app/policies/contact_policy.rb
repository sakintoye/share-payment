class ContactPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(owner_id: user.id)
    end
  end
end
