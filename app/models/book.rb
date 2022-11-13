class Book < ApplicationRecord
	
	validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
	
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy
	
	
	
	def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


	acts_as_taggable #追加
  # acts_as_taggable_on :tags　と同じ意味のエイリアス
  # tags のなかにIDやら名前などが入る。イメージ的には親情報。

  
end
