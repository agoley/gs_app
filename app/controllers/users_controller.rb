class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def admin_checked?
    user_params[:admin] == 1
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Game Swap " + @user.name + "!" 
      redirect_to @user
    else
      flash[:danger] = "Oops, there are some errors in the submission. Please see details below."
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if ( user_params[:admin] && !@user.admin? ) 
      @user.toggle!(:admin)
    end
#    if(user_params[:admin] == 0 || user_params[:admin] == nil)
#       puts "AGHHHHHHHHHHHHHHHHHH"
#       if @user.admin?
#	 @user.toggle!(:admin)
#       end
#    end
    if user_params[:admin].to_s <=> "0"
      if @user.admin?
        @user.toggle!(:admin)
      end
    end
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      flash[:danger] = "Oops, there are some errors updating your profile  " +  @user.name + ", please see the details below."
      render 'edit'
    end
  end
 
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end 

  private

    def user_params
      params.require(:user).permit(:admin, :name, :email, :password,
                                   :password_confirmation)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def current_user
      remember_token = User.digest(cookies[:remember_token])
      @current_user ||= User.find_by(remember_token: remember_token)
    end

    def current_user?(user)
      user == current_user
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
