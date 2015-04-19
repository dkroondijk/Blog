class Tag < ActiveRecord::Base

  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings

  validates :name, presence: true

  def self.tag_search(active_tag)
    where("name ILIKE ?", "%#{active_tag}%")
  end

end
