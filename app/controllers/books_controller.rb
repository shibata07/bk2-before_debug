class BooksController < ApplicationController

  before_action :authenticate_user!#ログインユーザーのみ

  def show
    @book = Book.new #追加 newbookフォーム用
    @book_detail = Book.find(params[:id]) #変数名変更
    @user = @book_detail.user #追加
  end

  def index
    @book = Book.new #追加
    @books = Book.all
    @user = current_user #追加
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id #追加
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      @user = current_user #追加
      render :index #変更
    end
  end

  def edit
    @book = Book.find(params[:id])

    if @book.user_id == current_user.id #編集に制限
       render :edit

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
    redirect_to books_path(@book)
  end

  private

  def book_params
    params.require(:book).permit(:title, :body) #body追加
  end

end
