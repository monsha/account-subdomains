class Account < ActiveRecord::Base
  attr_accessible :name, :subdomain
  
  has_many :users
end
