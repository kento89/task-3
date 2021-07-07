class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @users = @book.user
    @newbook = Book.new
    @book_comment = BookComment.new
  end

  def index
    books = Book.all
    @bookindex = books.includes(:favorites).sort{|a,b| b.favorites.size <=> a.favorites.size}
    @book = Book.new
    @user = User.find(current_user.id)
    @users = @book.user_id
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id == current_user.id
      render 'edit'
    else
      redirect_to books_path
    end
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

end
