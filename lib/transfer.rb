class Transfer
  @@all = []
  attr_accessor
  attr_reader :amount, :sender, :receiver, :status

  def initialize(sender_account, receiver_account, amount)
    @sender = sender_account
    @receiver = receiver_account
    @amount = amount
    #Note, this is the TRANSFER's Status, not the back account's status
    @status = "pending"
  end

  def valid?
    self.sender.valid? && self.receiver.valid? ? true : false
  end

  def sender_have_enough?
    self.sender.balance >= self.amount
  end

  def find_transaction_of_same_amount
    transaction_of_same_amount = self.sender.transaction_history
    transaction_of_same_amount.find {|past_transaction| past_transaction.amount == self.amount}
  end

  def add_transaction_to_history(account)
    account.transaction_history << self
  end

  def execute_transaction
    #Testing to see if the overall transaction is valid, then seeing if I did NOT find a previous transaction of the same amount, then checking if the sender has enough money, if all this is true, execute.
    if self.valid? && !find_transaction_of_same_amount && sender_have_enough?
      self.sender.balance -= self.amount
      self.receiver.balance += self.amount
      
      @status = "complete"
      add_transaction_to_history(sender)
      add_transaction_to_history(receiver)
      @@all << self
    else
      @status = "rejected"
      add_transaction_to_history(sender)
      add_transaction_to_history(receiver)
      @@all << self
      "Transaction rejected. Please check your account balance."
    end
  end

  def status=(status)
    @status = status
  end

  def reverse_transfer
    last_transaction = @@all[-1]
    if last_transaction.status == "complete"
      last_transaction.receiver.balance -= last_transaction.amount
      last_transaction.sender.balance += last_transaction.amount
      last_transaction.status = "reversed"
    else
      "This transaction was rejected.  Please execute and complete a transaction fully first."
    end
  end

end
