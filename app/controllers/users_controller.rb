class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end
  
  def new 
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'Book was succesfully created.'
      redirect_to books_path
    else
      @books = Book.all
      @user = User.find_by(id: current_user.id)
      render :index
    end
  end
  
  def index
    @users = User.all
    @user = User.find_by(id: current_user.id)
    @book = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'You have updated User successfully.'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  private
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
