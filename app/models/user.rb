class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books,dependent: :destroy
  attachment :profile_image, destroy: false
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy
  
  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}

	#フォローされているユーザーのリレーション
	has_many :passive_relationships,class_name: "Relationship",foreign_key: "followed_id",dependent: :destroy
	#Relationshipテーブルのfollowed_id(自分がフォローされているユーザーのid)と関連付ける
	
	#フォローしているユーザーのリレーション
	has_many :active_relationships,class_name: "Relationship",foreign_key: "follower_id",dependent: :destroy
	#Relationshipテーブルのfollower_id(自分がフォローしているユーザのid)と関連付ける
	
  #自分がフォローされているユーザーの一覧画面で使う
  has_many :followers,through: :passive_relationships,source: :follower
  #passive_relationshipsを経由してfollowerを持ってくる
  
  #自分がフォローしているユーザーの一覧画面で使う
  has_many :followings,through: :active_relationships,source: :followed
  #active_relationshipsを経由してfollowedを持ってくる

  
  def follow(user_id)
    active_relationships.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    active_relationships.find_by(followed_id: user_id).destroy
  end
  
  def followed_by?(user)
    #自分がフォローしようとしているユーザーのフォローされているユーザー内に自分が存在するかどうか
    passive_relationships.find_by(follower_id: user.id).present?
  end
end
