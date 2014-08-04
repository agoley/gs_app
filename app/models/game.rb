class Game < ActiveRecord::Base
  belongs_to :seller, class_name: "User"
  default_scope -> { order('created_at DESC') }
  validates :seller_id, presence: true
  validates :title, presence: true
  validates :console, presence: true
end
