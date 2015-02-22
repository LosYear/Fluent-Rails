class Node < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug

  # Relations
  belongs_to :aurhor, :foreign_key => "author", :class_name => "User"
  belongs_to :updater, :foreign_key => "updater", :class_name => "User"

  # Validation
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :title, presence: true
  validates :content, presence: true
  
  def self.inheritance_column
    nil
  end
end
