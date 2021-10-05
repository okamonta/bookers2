class Favorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :book
  
  # ユーザーがひとつのbookに対してひとつのいいねしかできないようにしている（scopeで範囲を指定して、一意かどうかを判断）（scopeは複数指定ok）
  validates_uniqueness_of :book_id, scope: :user_id
  
  # validates :book_id, uniqueness: true 
  # だとひとつのbookに対してひとつのいいねしかできなくなり、成立しない（全ユーザーで１いいね）
  
end
