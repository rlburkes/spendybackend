class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  
  def index
  	@users = User.paginate(page: params[:page])
  	
  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users.to_json }
    end
  end
  
  def show
  	@user = User.find_by_id(params[:id])
  	@expenses = @user.expenses.paginate(page: params[:page])
  	
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
