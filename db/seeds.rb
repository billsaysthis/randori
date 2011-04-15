if u = User.find_by_name('Alice')
  u.delete
end
User.create({:name => 'Alice', :password => '7643', :balance => 2000, :email => 'alice@example.com'})
if u = User.find_by_name('Bob')
  u.delete
end
User.create({:name => 'Bob', :password => '5954', :balance => 22400, :email => 'bob@example.com'})
if u = User.find_by_name('Clyde')
  u.delete
end
User.create({:name => 'Clyde', :password => '1562', :balance => 100, :email => 'clyde@example.com'})

if a = Atm.find(1)
  a.delete
end
Atm.create({:balance => 100000})
