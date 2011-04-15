require 'spec_helper'

describe Atm do
  let(:a_user) {{:name => 'Clyde', :password => '1562', :balance => 2000, :email => 'clyde@example.com'}}

  it "should have a current balance" do
    atm = Factory(:atm, :balance => 200)
    atm.balance.should eq(200)
  end

  it "should allow authorized users to withdraw cash" do
    user = Factory(:user, a_user)
    atm = Factory(:atm)
    end_atm_balance = atm.balance - 1000
    Transact.withdraw(user, atm, 1000)
    atm.reload.balance.should eq(end_atm_balance)
  end
  
end