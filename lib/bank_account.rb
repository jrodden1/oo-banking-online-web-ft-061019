require_relative "../config/environment"

class BankAccount
   attr_reader :name
   attr_accessor :balance, :status, :transaction_history

   def initialize(account_holder_name)
      @name = account_holder_name
      self.status = "open"
      self.balance = 1000
      self.transaction_history = []
   end
   
   def deposit(deposit_amount)
      self.balance += deposit_amount
   end

   def display_balance
      "Your balance is $#{self.balance}."
   end

   def valid?
      if self.status == "open" && self.balance > 0
         true
      else
         false
      end
   end

   def close_account
      self.status = "closed"
      self.status.freeze
   end

end
