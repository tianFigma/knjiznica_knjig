class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def show
    @book = Book.includes(:categories).find(params[:id])
  end

  def create
    @book = current_user.books.new(book_params)
  
    if @book.save
      # Handle the uploaded image and categories
      @book.categories << Category.find(params[:book][:category_ids].reject(&:blank?)) if params[:book][:category_ids].present?
      redirect_to books_path, notice: 'Book was successfully created.'
    else
      render :new
    end
  end
          

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    
    # Ensure current_user is set to the book if not already set
    @book.user = current_user unless @book.user == current_user
    
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: 'Book was successfully deleted.'
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :image, category_ids: [])
  end
end
