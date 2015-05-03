class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment

  validates :user_id, uniqueness: {scope: :comment_id}

  scope :up,   lambda { where(is_up: true)  }
  scope :down, lambda { where(is_up: false) }
end
