class BooksController < ApplicationController
  
  # new ページがないので、newアクションはいらない？
  # def new
  # end
  
  # /books ページ(index)で Create Book を表示する。（/users /books）
  # /books ページ(index)で 投稿ユーザーの profile_image_id が表示される。
  # books_controller 内で userの変数を受け取ることは可能なのか？
  def index
    @books = Book.all
    @book = Book.new
    # @user = @book.users.page(params[:page]).reverse_order
    # @user = User.find(params[:id])
  end
  
  # /books/:id [Book detail] にも Create Book がある。editページにもとぶ。
  # /users/:id からとべる。逆も然り。
  # books_controller 内で userの変数を受け取ることは可能なのか？
  def show
    @book = Book.find(params[:id])
    @book = Book.new
    # @user = User.find(params[:id])
  end
  
  # 成功したらshow,失敗したらindex
  # 許可されているパラメーターかどうかの確認。
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      # render :index
      render books_path
    end
  end
  
  # Editing Book
  # updateがある。
  # /books/:id (show) からとべる。
  def edit
  end
  
  def update
  end

  def destroy
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :opinion)
  end

end
