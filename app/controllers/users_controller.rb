class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
    @book = Book.new
  end

  def new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user), notice: 'successfully'
    else
      redirect_to user_path(current_user), notice: 'error'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    if current_user.id != @user.id
      redirect_to user_path(current_user), notice: 'error!!'
    end
  end
end
