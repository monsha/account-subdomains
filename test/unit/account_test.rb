require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  fixtures :accounts 
  
  test "subdomain must be unique" do
    account = Account.new subdomain: accounts(:steve).subdomain, name: "Bill Gates"
    assert !account.save
    assert_equal "has already been taken", account.errors[:subdomain].join('; ')
  end

  test "subdomain can't be blank" do
    account = Account.new subdomain: '', name: "Bill Gates"
    assert !account.save
    assert_equal "can't be blank", account.errors[:subdomain].join('; ')
  end

  test "name can't be blank" do
    account = Account.new subdomain: 'billgates', name: ""
    assert !account.save
    assert_equal "can't be blank", account.errors[:name].join('; ')
  end
  
  test "subdomain invalid format" do
    nok = %w{bill.gates bi/ll bill-gates bill@#$%^&*() 3bill }
    ok = %w{bill_gates bill3 billgates b123 }
    nok.each do |subdomain|
      account = Account.new subdomain: subdomain, name: "Bill Gates"
      assert account.invalid?, "#{subdomain} shouldn't be valid"      
      assert_equal "Only letters, numbers and '_' allowed and don't start with number", account.errors[:subdomain].join('; ')
    end
    ok.each do |subdomain|
      account = Account.new subdomain: subdomain, name: "Bill Gates"
      assert account.valid?, "#{subdomain} shouldn't be invalid"      
    end
  end
  
end
