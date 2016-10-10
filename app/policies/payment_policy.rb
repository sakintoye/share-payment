class PaymentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(recipient_id: user.id, date_withdrawn: nil)
    end
  end

  def create?
  	if user.id == record.sender_id
  		true
  	else
  		false
  	end
  end

  def withdraw?
    if user.id == record.recipient_id
      true
    else
      false
    end
  end

  def update?
    if user.id == record.sender_id
      true
    else
      false
    end
  end
end
