require 'spec_helper'

describe Transact do
  let(:a_user) {{:name => 'Clyde', :password => '1562', :balance => 100, :email => 'clyde@example.com'}}

  before :each do
    @user = Factory(:user, a_user)
    @atm = Factory(:atm)
  end
  
  it "should not be allowed to withdraw more money than current balance" do
    trx = Transact.new(:user => @user, :atm => @atm)
    trx.amount = (@user.balance+1000).to_d
    trx.should_not be_valid
  end
  
  it "should not allow withdrawals exceeding a user's balance" do
    Transact.withdraw(@user, @atm, 1000).should_not eq("GOOD")
  end

  it "should not allow withdrawals exceeding the cash on hand" do
    Transact.withdraw(@user, @atm, 1000).should_not eq("GOOD")
  end
  
  it "should allow withdrawals when amount is less than user and ATM balances" do
    Transact.withdraw(@user, @atm, 20).should eq("GOOD")
  end
end
