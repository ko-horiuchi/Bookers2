class BooksController < ApplicationController
  before_action :ensure_book, only: [:edit, :update, :destroy]

  def top
  end

  def about
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @user = current_user
    @book = Book.find(params[:id])
    @a_user = @book.user
    @new_book = Book.new
  end

  def edit
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice:'You have created book successfully.'
    else
      @books = Book.all
      @user = current_user
      render "index"
    end
  end

  def update
    if @book.update(book_params)
       redirect_to book_path(@book.id),  notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def ensure_book
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

end