class Follow < ApplicationRecord
  belongs_to :active_follower, class_name: 'User', foreign_key: 'active_follow_id'
  belongs_to :passive_followed, class_name: 'User', foreign_key: 'passive_follow_id'
end
