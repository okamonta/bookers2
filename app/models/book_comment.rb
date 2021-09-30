class BookComment < ApplicationRecord
  belongs_to :book
  belongs_to :user
  
  # 空のメッセージでエラーにならない。
  validates :comment, presence: true
end
