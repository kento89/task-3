class BooksController < ApplicationController
  impressionist actions: [:index, :show]
  
  def show
    @book = Book.find(params[:id])
    # impressionist(@book, nil, unique: [:session_hash])
    @users = @book.user
    @newbook = Book.new
    
    @book_comment = BookComment.new
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @users.id)
    unless @users.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom=true
            @roomId=cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room=Room.new
        @entry=Entry.new
      end
    end
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
