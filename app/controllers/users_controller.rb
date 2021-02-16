class UsersController < ApplicationController
  before_action :ensure_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def new
    @post_image = PostImage.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
       redirect_to user_path(@user.id), notice: 'You have updated user successfully.'
    else
       render :edit
    end
  end

  private
  def ensure_user
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to  user_path(current_user)
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end


end
