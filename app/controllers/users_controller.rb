class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  
  def index
  	@users = User.paginate(page: params[:page])
    @total = Expense.sum(:amount)
    @numUsers = User.count
    @average = @total / Expense.count
    @tags = Expense.tag_counts_on(:tags).limit(3).order('count desc')
  	
  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users.to_json }
    end
  end
  
  def show
  	@user = User.find_by_id(params[:id])
  	@expenses = @user.expenses.paginate(page: params[:page])
  	@total = @expenses.sum(:amount)
  	
  	respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user.to_json }
    end
  end
  
  def new
  	@user = User.new
  end
  
  def create
    @user = User.new(params[:user])    # Not the final implementation!
    if @user.save
      sign_in @user
      flash[:success] = "Thanks for joining Spendy!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
  
  private
	def user_params
	  params.require(:user).permit(:name, :email, :password,
									   :password_confirmation)
	end
  
end
