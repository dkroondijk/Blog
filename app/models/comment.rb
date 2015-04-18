class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  has_many :votes, dependent: :destroy
  has_many :voted_users, through: :votes, source: :user

	validates :body, presence: true

  def self.search(search)
      where("body ILIKE ?", "%#{search}%")
  end

  def self.most_recent
    order("created_at DESC")
  end

  def time_since_post    
    ((Time.now - created_at)/60).to_i
  end

end
