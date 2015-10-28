class Photo < ActiveRecord::Base
  belongs_to :product

  mount_uploader :image, ImageUploader
end

# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  product_id :integer
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
