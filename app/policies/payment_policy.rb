class PaymentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(recipient_id: user.id, date_withdrawn: nil)
    end
  end
end
