class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :subdomain
      t.string :name
      t.timestamps
    end
    
    change_table :users do |t|
      t.references :account
    end
    
  end
end
