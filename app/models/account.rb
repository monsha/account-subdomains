class Account < ActiveRecord::Base
  attr_accessible :name, :subdomain
  
  has_many :users
  
  validates :name, :subdomain, presence: true
  validates :subdomain, :format => { :with => /\A[^0-9]\w+\z/,
      :message => "Only letters, numbers and '_' allowed and don't start with number" } , allow_blank: true
  validates :subdomain, uniqueness: true    
end
