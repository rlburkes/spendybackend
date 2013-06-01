class ExpensesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy
  
  def index
  end
  
  def enter
      @tags = current_user.expenses.tag_counts_on(:tags)
  end
  
  def create
    @expense = current_user.expenses.build(params[:expense])
    if @expense.save
      flash[:success] = "Expense entered!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      @tags = current_user.feed.tag_counts_on(:tags)
      render 'static_pages/home'
    end
  end
  
  def tagged
    @tags = current_user.feed.tag_counts_on(:tags)
    @users = current_user.friends
    @foo = params[:user].split(',').map(&:to_i)
    @includeIds = current_user.friend_ids - @foo
    if params[:tag].present? 
      @expenses = Expense.tagged_with(params[:tag], any: true).where(:user_id => @includeIds)
      @total = 0.00
      @expenses.each do |expense|
        @total += expense.amount
      end
      #Why is this not the same as looping and adding?
      #@total = @expenses.sum(:amount, :distinct => true)
    else 
     @expenses = current_user.feed.where(:user_id => @includeIds)
     @total = @expenses.sum(:amount) 
    end  
  end
  
  def destroy
    @expense.destroy
    redirect_to root_url
  end

  private

    def correct_user
      @expense = current_user.expenses.find_by_id(params[:id])
      redirect_to root_url if @expense.nil?
    end
end