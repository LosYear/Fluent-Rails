class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug

  # General
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :type, presence: true
  # Blog post validation
  validates :title, presence: true, if: :blog_post?
  validates :content, presence: true, if: :blog_post?
  validates :preview, presence: true, if: :blog_post?

  def self.inheritance_column
    nil
  end

  def blog_post?
    type == "post"
  end
end
