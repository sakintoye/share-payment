class Contact < ActiveRecord::Base
  belongs_to :contact, class_name: 'User', foreign_key: 'contact_id'
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
end
