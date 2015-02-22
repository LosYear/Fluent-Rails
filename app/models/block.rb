class Block < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name

  # Validation
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :title, presence: true
  validates :content, presence: true
  validates :type, presence: true

  def self.inheritance_column
    nil
  end
end
