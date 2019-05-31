class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @users = User.all
    @books = Book.all
    @book = Book.new
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @books = Book.all
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to book_path(@book), notice: 'Book was successfully created.'
    else
      puts @book.errors.full_messages
      render :index, notice: 'error'

    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      redirect_to book_path(book), notice: 'successfully'
    else
      redirect_to book_path(book), notice: 'error'
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    redirect_to books_path, notice: 'Book was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def correct_user
      book = Book.find(params[:id])
      # belong_toのおかげでbookオブジェクトからuserオブジェクトへアクセスできる。
      if current_user.id != book.user.id
        redirect_to books_path, notice: 'error!!'
      end
    end
end
