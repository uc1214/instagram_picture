class Picture < ActiveRecord::Base
  validates :img, presence: true
  validates :content, presence: true

  mount_uploader :img, ImgUploader

  belongs_to :user
end
