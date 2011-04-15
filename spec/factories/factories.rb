require 'spec_helper'

Factory.define :user do |user|
  user.name "my name"
  user.password "my pin"
  user.balance 100
  user.email "example@example.com"
end
  
Factory.define :atm do |atm|
  atm.balance 100000
end

Factory.define :transact do |transact|
  transact.amount 20
  transact.association :user
  transact.association :atm
end
