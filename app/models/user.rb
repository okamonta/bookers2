class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  # 自分がフォローされる側（被フォロー）の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分がフォローする側（与フォロー）の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

  # 自分をフォローしている人を参照。被フォロー関係を通じて、自分をフォローしている人（follower）を参照。
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 自分がフォローしている人を参照。与フォロー関係を通じて、自分にフォローされている人（followed）を参照。
  # 自分がフォローしている人＝自分にフォローされている人（followed）
  has_many :followings, through: :relationships, source: :followed
  
  
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
    followings.include?(user)
  end
  
  # カラムはprofile_image_id、ここでは_idはいらない。（rails7章）
  attachment :profile_image, destroy: false
  
  # nameが空or２文字以下だとエラー
  # アプリ側とDB側の両方に記述する必要があった。
  validates :name, presence: true, length: {minimum: 2, maximum: 20}, uniqueness: true
  
  # introduction 最大５０文字
  validates :introduction, length: {maximum: 50}
  
  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end
end
