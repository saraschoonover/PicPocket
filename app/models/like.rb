# == Schema Information
#
# Table name: likes
#
#  id          :integer          not null, primary key
#  caption     :string
#  image       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  photo_id    :integer
#  user_id     :integer
#
# Indexes
#
#  index_likes_on_category_id  (category_id)
#  index_likes_on_photo_id     (photo_id)
#  index_likes_on_user_id      (user_id)
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#  photo_id     (photo_id => photos.id)
#  user_id      (user_id => users.id)
#
# app/models/like.rb
class Like < ApplicationRecord
  belongs_to :photo
  belongs_to :user
  belongs_to :category, optional: true

  # Add a virtual attribute for category_name
  attr_accessor :category_name

  # before_validation callback to set category based on category_name
  before_validation :set_category_from_name

  # other attributes like caption, image, etc.

  private

  def set_category_from_name
    return unless category_name.present?
    # Find or create the category based on the name
    self.category = Category.find_or_create_by(name: category_name)
  end
end
