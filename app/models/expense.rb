class Expense < ActiveRecord::Base
  attr_accessible :amount
  belongs_to :user
  
  validates :user_id, presence: true
  validates :amount, presence: true, numericality: true
  
  default_scope order: 'expenses.created_at DESC'
end
