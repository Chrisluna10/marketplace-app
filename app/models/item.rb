class Item < ApplicationRecord
    belongs_to :user

    has_one_attached :image do |attachable|
        attachable.variant :thumb, resize_to_limit: [150, 150]
      end 

      scope :has_attached_image, -> { joins(:image_attachment) }
end
