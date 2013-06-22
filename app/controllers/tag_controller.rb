class TagController < ApplicationController

  def index
     if params[:q].present?
       parameter = params[:q].split(', ').last
       @tags = Expense.where(:user_id => current_user.friend_ids).tag_counts_on(:tags).where("LOWER(name) LIKE ?", "#{parameter.downcase}%").order('count desc')
     else
       @tags = Expense.where(:user_id => current_user.friend_ids).tag_counts_on(:tags).order('count desc')
     end
     respond_to do |format|
       format.json { render json: @tags.to_json }
     end
  end
end
