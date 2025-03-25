class CategoriesController < ApplicationController
    before_action :authenticate_user!
  
    def show
      @category = Category.find(params[:id])
      @books = @category.books
    end
  
    def new
      @category = Category.new
    end
  
    def create
      @category = Category.new(category_params)
      if @category.save
        redirect_to @category, notice: "Category was successfully created."
      else
        render :new
      end
    end
  
    private
    def category_params
      params.require(:category).permit(:name)
    end
  end
  