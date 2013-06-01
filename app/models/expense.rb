
class Expense < ActiveRecord::Base
  attr_accessible :amount, :tag_list
  belongs_to :user
  
  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :tags
  
  validates :user_id, presence: true
  validates :amount, presence: true, numericality: true
  
  default_scope order: 'expenses.created_at DESC'
  
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
                         
    #followed_user_ids =  "SELECT * FROM (SELECT * FROM relationships
    #                      WHERE follower_id = :user_id) WHERE followed_id = :user_id"
                         
    self.where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
  
end
