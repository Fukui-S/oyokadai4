class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comment, dependent: :destroy

  attachment :profile_image
  
  # フォローしているユーザとのアソシエイト
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  # 
  
  # フォローされているユーザーとのアソシエイト
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following
  # 
  # ユーザーをフォローする時既にフォローしていないか
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
  # 
  
  validates :name, presence: true, uniqueness: true, length:{ minimum: 2, maximum: 20}
  validates :introduction, length: { maximum: 50}

end
