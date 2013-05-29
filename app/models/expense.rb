class Expense < ActiveRecord::Base
  attr_accessible :amount, :user_id
end
