class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  # the scope implies that the combination of the user_id 
  # and post_id for the like must be unique
  validates :user_id, uniqueness: {scope: :post_id}

  

end
