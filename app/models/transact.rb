class Transact < ActiveRecord::Base
  belongs_to :user
  belongs_to :atm

	validates :amount, :presence => true
	validates_numericality_of :amount, :minimum => 0
  validate :validate_balances
  
  def validate_balances
    unless (user.balance >= amount)
      errors.add(:amount, "must be less than user's account balance")
    end
    unless (atm.balance >= amount)
      errors.add(:amount, "must be less than ATM balance")
    end
  end
  
  def self.withdraw(p_user, p_atm, amount)
    user = User.find(p_user)
    atm = Atm.find(p_atm)

    if (user.present? and atm.present?)
      if user.withdrawal amount
        if atm.withdrawal amount
          begin
            trx = Transact.create(:user => user, :atm => atm, :amount => amount)
          rescue
            # reverse withdrawals
            atm.deposit amount
            user.deposit amount
            msg = "Could not complete transaction"
          end
        else
          msg = "Could not withdraw desired amount from this ATM" 
        end
      else
        msg = "Could not withdraw desired amount from your account" 
      end
    else
      msg = "Please supply valid user and ATM"
    end
    msg || "GOOD"
  end
end
