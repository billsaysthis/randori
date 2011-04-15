require 'spec_helper'

# People
# | Person | Pin  | Balance |
# | Alice  | 7643 | 2000    |
# | Bob    | 5954 | 22400   |  
# | Clyde  | 1562 | 100     |

describe User do
  let(:users) {[
    {:name => 'Alice', :password => '7643', :balance => 2000, :email => 'alice@example.com'},
    {:name => 'Bob', :password => '5954', :balance => 22400, :email => 'bob@example.com'},
    {:name => 'Clyde', :password => '1562', :balance => 100, :email => 'clyde@example.com'}
  ]}
  let(:a_user) {users.first}
  
  it "should be allowed to login if correct credentials are supplied" do
    good_count = 0
    users.each do |u|
      user = Factory(:user, u)
      login_as user
      user.valid_for_authentication? { true }
      good_count = good_count + (user.failed_attempts == 0 ? 1 : 0)
    end
    good_count.should eq users.count
  end
  
  it "should have a pin which contains only digits" do
    a_user[:password] = 'notdigits'
    User.new(a_user).should have(1).error_on(:password)
  end
  
  it "should be allowed to withdraw money" do
    user = Factory(:user, a_user)
    atm = Factory(:atm)
    Transact.withdraw(user, atm, 1000).should eq("GOOD")
  end
  
  it "should be allowed only three invalid login attempts" do
    user = Factory(:user, a_user)
    3.times { user.valid_for_authentication?{ false } }
    user.should be_access_locked
  end
  
  it "should be able to see account balance" do
    user = Factory(:user, a_user)
    user.balance.should eq(a_user[:balance])
  end
end
