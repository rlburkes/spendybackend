class ExpensesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy
  
  def index
  end
  
  def create
    @expense = current_user.expenses.build(params[:expense])
    if @expense.save
      flash[:success] = "Expense entered!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end
  
  def tagged
    if params[:tag].present? 
      @expenses = Expense.tagged_with(params[:tag])
      @total = @expenses.sum(:amount)
    else 
      @expenses = Expense.postall
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