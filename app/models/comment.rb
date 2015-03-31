class Comment < ActiveRecord::Base
	validates :body, presence: true

  def self.search(search)
      where("body ILIKE ?", "%#{search}%")
  end

end
