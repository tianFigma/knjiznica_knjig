class BooksController < ApplicationController
    def index
      @books = Book.all
    end
  
    def new
      @book = Book.new
    end
  
    def show
        @book = Book.find(params[:id])
      end

      def create
        @book = current_user.books.new(book_params)
        
        if @book.save
            @book.categories << Category.find(params[:book][:category_ids].reject(&:blank?)) if params[:book][:category_ids].present?
            redirect_to books_path, notice: 'Book was successfully created.'
          else
            render :new
          end
      end          
      
  
    private
  
    def book_params
        params.require(:book).permit(:title, :author,:description, :user_id, :category_id)
      end
  
    
  end
  