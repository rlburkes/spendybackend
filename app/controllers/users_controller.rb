class UsersController < ApplicationController
  
  def index
  	@users = User.all
  end
  
  def show
  	@user = User.find_by_id(params[:id])
  end
  
  def new
  	@user = User.new
  end
  
  def create
    @user = User.new(params[:user])    # Not the final implementation!
    if @user.save
      flash[:success] = "Thanks for joining Spendy!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end
  
end
