class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :name, :balance
    
  has_many :transacts
  has_many :atms, :through => :transacts

	validates :balance, :presence => true
	validates_numericality_of :balance, :minimum => 0
  validate :valid_pin, :on => :create
  
  def valid_pin
    if (/[0-9]{4}/ =~ password) == nil
        errors.add(:password, "must be composed only of digits")
      end
    end

  def withdrawal amount
    new_balance = balance.to_i - amount.to_i
    return (new_balance > 0) ? update_attributes(:balance => new_balance) : false
  end
  
  def deposit amount
    new_balance = balance.to_i + amount.to_i
    return update_attributes({:balance => new_balance})
  end
  
  def self.check_bad_auth name, pwd
    user = User.find_by_name(name)
    if user
      # we already know if this case then password bad
      user.valid_for_authentication?{ false }
      # too many bad attempts?
      msg = (user.access_locked?) ? 
        "Your account has been locked for too many incorrect logins. Please contact our Customer Service Department." :
        "Your account could not be confirmed. Please try again"
    else
      msg = "Please supply valid name and PIN"
    end
    msg
  end
end
