class UsersController < ApplicationController
  
  # /users に Create Book がある。
  def index
    @users = User.all
    @user = User.find(params[:id])
  end
  
  # /users/:id に Create Book がある。
  # /books/:id にもとぶ。自分と他人の book のshow ページが見れる。逆も然り。
  # _idいらない？そもそも定義いらない？
  def show
    @user = User.find(params[:id])
    # @book = Book.find(params[:id])
  end
  
  # User info
  # Name Image Introduction の編集
  # Update User でアップデート
  def edit
    @user = User.find(params[:id])
  end
  
  # edit からとべる。
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end
  
  # name introduction image のカラム追加完了。nameがdeviseのでいいのか微妙だけど、追加できなかったから多分大丈夫。
  # ここでも_idはいらないっぽい（rails7章）
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)  
  end
  
end
