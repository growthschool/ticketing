class Product < ActiveRecord::Base
  has_many :photos

  accepts_nested_attributes_for :photos

  def default_photo
    photos.last
  end
end

# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  quantity    :integer
#  price       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
