# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  caption    :string
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  photo_id   :integer
#  user_id    :integer
#
# Indexes
#
#  index_likes_on_photo_id  (photo_id)
#  index_likes_on_user_id   (user_id)
#
# Foreign Keys
#
#  photo_id  (photo_id => photos.id)
#  user_id   (user_id => users.id)
#
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :photo
  
end
