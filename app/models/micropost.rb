class Micropost < ApplicationRecord
  
  # has_manyだけでは消せない
  
  
  # 'favorites.micropost_id'で消そうとしているのを、
  # micropost_id = fav_id で探して消してねという記述にするための何か
  
  # フォロー関係の書き換え
  has_many :favorites
  has_many :favs, through: :favorites, source: :fav
  
  # これにdependent: :destroyを付けたらファボられ投稿も消えるようになった。何故？？？
  has_many :reverses_of_favorite, class_name: 'Favorite', foreign_key: 'fav_id', dependent: :destroy
  
  has_many :favers, through: :reverses_of_relationship, source: :user
  
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
end
