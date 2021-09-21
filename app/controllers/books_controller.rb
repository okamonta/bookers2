class BooksController < ApplicationController
  
  # /books/:id [Book detail] にも Create Book がある。editページにもとぶ。
  # /users/:id からとべる。逆も然り。
  # books_controller 内で userの変数を受け取ることは可能なのか？
  # @newbookがなんなのか？
  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end
  
  # /books ページ(index)で Create Book を表示する。（/users /books）
  # /books ページ(index)で 投稿ユーザーの profile_image_id が表示される。
  # books_controller 内で userの変数を受け取ることは可能なのか？
  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
    # @user = @book.users.page(params[:page]).reverse_order
    # @user = User.find(params[:id])
    # @user = User.find
  end
  
  # 成功したらshow,失敗したらindex
  # 許可されているパラメーターかどうかの確認。
  def create
    @book = Book.new(book_params)
    # わからず！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
    # bookモデルにuser_idが追加されてなかった。
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
      # render books_path
    end
  end
  
  # Editing Book
  # updateがある。
  # /books/:id (show) からとべる。
  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice]="Book was successfully destroyed."
      redirect_to books_path
    end
  end
  
  # opinionではなく、カラムはbody。
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
