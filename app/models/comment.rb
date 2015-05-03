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
    minutes_since_post = ((Time.now - created_at)/60).to_i
    hours_since_post = minutes_since_post/60
    days_since_post = hours_since_post/24
    if minutes_since_post < 60
      "#{minutes_since_post}" + " minute".pluralize(minutes_since_post)
    elsif hours_since_post < 24
      "#{hours_since_post}" + " hour".pluralize(hours_since_post)
    else
      "#{days_since_post}" + " day".pluralize(days_since_post)
    end
  end

  def votes_count
    votes.up.count - votes.down.count
  end

end
