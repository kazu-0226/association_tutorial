class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets
  has_many :favorites
  has_many :favorite_tweets, through: :favorites, source: :tweet
  has_many :comments

  #フォローする側のUserから見て、フォローされる側のUserを(中間テーブルを介して)集める。なので親はfollowing_id(フォローする側)
  has_many :followings, class_name: "Relationship", foreign_key: :following_id  #フォローを取得
  has_many :followers, class_name: "Relationship", foreign_key: :follower_id #フォロワー取得
  #followerモデル（フォローされる側を集めたUserモデル）から自分のフォローしているひとを集める
  has_many :following_user, through: :followings, source: :follower 
  #followingモデル（フォローする側を集めたUserモデル）から自分をフォローしているひとを集める
  has_many :follower_user, through: :followers, source: :following

  def followed_by?(user)
    followers.find_by(following_id: user.id).present?
  end
  
end
