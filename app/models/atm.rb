class Atm < ActiveRecord::Base
  has_many :transacts
  has_many :users, :through => :transacts

	validates :balance, :presence => true
	validates_numericality_of :balance, :minimum => 0

  def withdrawal amount
    new_balance = balance.to_i - amount.to_i
    return (new_balance > 0) ? update_attributes(:balance => new_balance) : false
  end
  
  def deposit amount
    new_balance = balance.to_i + amount.to_i
    return update_attributes({:balance => new_balance})
  end
  
  def self.default_machine
    Atm.first.id
  end
end
