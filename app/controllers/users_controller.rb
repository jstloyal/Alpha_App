class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]
  before_action :require_same_user, only: %i[edit update destroy]
  before_action :require_admin, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
    # set_user
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'User successfully updated!'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user.destroy
    flash[:danger] = 'User and all user article is successfully deleted'
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = 'You can only edit your own account'
      redirect_to root_path
    end
  end

  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger] = 'Only admin can perform this action!'
      redirect_to root_path
    end
  end
end
