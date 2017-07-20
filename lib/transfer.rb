class Transfer
	attr_accessor :status
	attr_reader :sender, :receiver, :amount


	def initialize(sender, receiver, amt)
		@sender = sender
		@receiver = receiver
		@amount = amt
		@status = "pending"
	end

	def valid?
		valid_sender? && valid_receiver?
	end

	def valid_sender?
		@sender.valid?
	end

	def valid_receiver?
		@receiver.valid?
	end

	def valid_sender_balance?
		balance = self.sender.balance
		(balance -= self.amount) >= 0
	end

	def execute_transaction
		if valid? && self.status != "complete" && valid_sender_balance?
				self.sender.balance -= self.amount
				self.receiver.balance += self.amount
				self.status = "complete"
		else
			self.status = "rejected"
			"Transaction rejected. Please check your account balance."
		end

	end

	def reverse_transfer
		if self.status == "complete"
			self.sender.balance += self.amount
			self.receiver.balance -= self.amount
			self.status = "reversed"
		end
	end



end
