class ExpensesController < ApplicationController
  include ApplicationHelper

  before_filter :signed_in_user, only: [:create, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update, :destroy]
  
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
  
  def edit
    @expense = Expense.find(params[:id])
  end
  
  def update
    @expense = Expense.find(params[:id])
    if @expense.update_attributes(params[:expense])
      flash[:success] = "Expense updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end
  
  def tagged
    @tags = current_user.feed.tag_counts_on(:tags)
    @users = current_user.friends
    @user = current_user
    @includeIds = current_user.friend_ids

    if params[:user].present?
      @includeIds = @includeIds - params[:user].split(',').map(&:to_i)
    end
    if params[:tag].present? 
      @expenses = Expense.tagged_with(params[:tag], any: true).where(:user_id => @includeIds)
      @total = 0.00
      @expenses.each do |expense|
        @total += expense.amount
      end
      @last = Expense.tagged_with(params[:tag], any: true).where(:user_id => @includeIds, created_at: 1.week.ago.beginning_of_week(get_day_symbol_for_int(@user.week_start))..1.week.ago.end_of_week(get_day_symbol_for_int(@user.week_start))).sum(:amount)
      @this = Expense.tagged_with(params[:tag], any: true).where(:user_id => @includeIds, created_at: Time.now.beginning_of_week(get_day_symbol_for_int(@user.week_start))..Time.now.end_of_week(get_day_symbol_for_int(@user.week_start))).sum(:amount)
      #Why is this not the same as looping and adding?
      #@total = @expenses.sum(:amount, :distinct => true)
    else 
     @expenses = current_user.feed.where(:user_id => @includeIds)
     @total = @expenses.sum(:amount)
     @last = Expense.where(:user_id => @includeIds, created_at: 1.week.ago.beginning_of_week(get_day_symbol_for_int(@user.week_start))..1.week.ago.end_of_week).sum(:amount)
     @this = Expense.where(:user_id => @includeIds, created_at: Time.now.beginning_of_week(get_day_symbol_for_int(@user.week_start))..Time.now.end_of_week(get_day_symbol_for_int(@user.week_start))).sum(:amount)
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