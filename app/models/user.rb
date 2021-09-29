class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  
  # カラムはprofile_image_id、ここでは_idはいらない。（rails7章）
  attachment :profile_image, destroy: false
  
  # nameが空or２文字以下だとエラー
  # アプリ側とDB側の両方に記述する必要があった。
  validates :name, presence: true, length: {minimum: 2, maximum: 20}, uniqueness: true
  
  # introduction 最大５０文字
  validates :introduction, length: {maximum: 50}
end
