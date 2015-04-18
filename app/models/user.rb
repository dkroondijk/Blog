class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  # links User to Post by matching the 'source' to a 'belongs to'
  # in the favourites model
  has_many :favourites, dependent: :destroy
  has_many :favourited_posts, through: :favourites, source: :post

  has_many :votes, dependent: :destroy
  has_many :voted_comments, through: :votes, source: :comment

  def display_name
    if first_name || last_name
      "#{first_name} #{last_name}".strip.squeeze(" ")
    else
      email
    end
  end
  
  
end
