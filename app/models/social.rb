class Social < ActiveRecord::Base
  # Validations
  has_attached_file :logo, :styles => {:home => "150x150"}
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  validates :title, presence: true
  validates :link, presence: true
  validates :order, presence: true, numericality: { only_integer: true }
  validates :status, presence: true
  validates :logo, presence: true
end
