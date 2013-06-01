class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @expense = current_user.expenses.build
      @tags = current_user.feed.tag_counts_on(:tags)
   	  @feed_items = current_user.feed.paginate(page: params[:page])
   	else 
   	  render :layout => 'landing' 
   	end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end
