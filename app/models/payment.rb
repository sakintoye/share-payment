class Payment < ActiveRecord::Base
	belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
	belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'
	enum status: {pending: 1, withdrawn: 2, declined: 3, canceled: 4}
	enum direction: {inbound: 'inbound', outbound: 'outbound'}
end
