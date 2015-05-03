class Post < ActiveRecord::Base

  # using friendly_id gem for better url
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user

  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_many :favourites, dependent: :destroy
  has_many :favourited_users, through: :favourites, source: :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  accepts_nested_attributes_for :tags

  # code for paperclip image uploading
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	validates :title, presence: true, uniqueness: { case_sensitive: false }

  def self.search(search)
    where("title ILIKE ? OR body ILIKE ?", "%#{search}%", "%#{search}%")
  end

  def likes_for(user)
    likes.find_by_user_id(user.id) if user
  end

  # creates 'friendly id'--> not working!!
  # Also, better to use friendly_id gem instead
  # def to_param
  #   "#{id}-#{title}".parameterize
  # end

  scope :most_recent, lambda { order("created_at DESC") }

end
