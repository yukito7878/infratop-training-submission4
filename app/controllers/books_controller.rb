class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def new 
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'Book was successfully created'
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = User.find_by(id: current_user.id)
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = User.find_by(id: current_user.id)
  end
  
  def edit
    @users = User.all
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'Book was successfully updated.'
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  
  def show
    
    @book = Book.find(params[:id])
    @user = User.find_by(id: @book.user_id)
    
  end
  
  def destroy
    book = Book.find(params[:id])
    if book.destroy
      flash[:notice] = 'Book was successfully destroyed.'
      redirect_to books_path
    else
      flash[:notice] = 'Book was somehow not destroyed.'
      redirect_to '/books'
    end
    
  end
  
  private
  
  def is_matching_login_user
    book = Book.find(params[:id])
    user = User.find(book.user_id)
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
