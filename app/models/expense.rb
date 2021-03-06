
class Expense < ActiveRecord::Base
  attr_accessible :amount, :tag_list
  belongs_to :user
  
  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :tags
  
  validates :user_id, presence: true
  validates :amount, presence: true, numericality: true
  validates :tag_list, presence: true
  
  default_scope order: 'expenses.created_at DESC'
  
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
                     
    self.where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)      
  end
  
  def self.expenses_of_user_and_friends(user)
    friend_ids = user.friend_ids                       
    self.where(:user_id => friend_ids)   
  end
  
end
