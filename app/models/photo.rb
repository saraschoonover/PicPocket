# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  caption    :string
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Photo < ApplicationRecord

  has_many :likes, class_name: "Like", foreign_key: "photo_id", dependent: :destroy
  has_many :fans, through: :likes

  def self.create_from_unsplash(api_data)
    create!(
      caption: api_data[:alt_description] || api_data[:description] || 'No caption available',
      image: api_data[:urls][:regular],

    )
  end
end
