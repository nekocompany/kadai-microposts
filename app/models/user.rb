class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                  uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :microposts
  
  has_many :microposts
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  # ファボ関係
  # お気にいられも入れる
  has_many :favorites
  has_many :favs, through: :favorites, source: :fav
  
  # ファボられ
  # 課題の仕様にはない
  # ファボされたツイート一覧？
  # ファボしてきたユーザー一覧？
  # has_many :reverses_of_favorite, class_name: 'Favorite', foreign_key: 'fav_id'
  # has_many :favoriters, through: :reverses_of_favorite, source: :user
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  # タイムライン表示用
  # following_ids は User モデルの has_many :followings, ... によって
  # 自動的に生成されるメソッドです。

  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
  
  def fav(other_micropost)
    # ファボ出来るツイートは誰のツイートでもよい
    
    self.favorites.find_or_create_by(fav_id: other_micropost.id)
    
  end
  
  def unfav(other_micropost)
    favorite = self.favorites.find_by(fav_id: other_micropost.id)
    favorite.destroy if favorite
  end

  def fav?(other_micropost)
    self.favs.include?(other_micropost)
  end
  
 
  
end
