class UsersController < ApplicationController
  
  # /users に Create Book がある。
  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
    # @user = User.find(params[:id])
  end
  
  # /users/:id に Create Book がある。
  # /books/:id にもとぶ。自分と他人の book のshow ページが見れる。逆も然り。
  # _idいらない？そもそも定義いらない？
  # Book.where の引数がわからん
  def show
    @user = User.find(params[:id])
    @book = Book.new
    # @books = Book.all
    # @books = Book.where(user_id: @user.id)
    # @books = Book.where
    @books = Book.where(user_id: @user.id)
  end
  
  # User info
  # Name Image Introduction の編集
  # Update User でアップデート
  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end
  
  # edit からとべる。
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end
  
  # name introduction image のカラム追加完了。nameがdeviseのでいいのか微妙だけど、追加できなかったから多分大丈夫。
  # ここでも_idはいらないっぽい（rails7章）
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)  
  end
  
end
