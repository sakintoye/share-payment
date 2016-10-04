class SenderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      Payment.where(sender_id: user.id)
    end
  end
end