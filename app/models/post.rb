class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug

  # Default sorted by date
  default_scope {order(created_at: :desc)}

  # General
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :type, presence: true
  # Blog post validation
  validates :title, presence: true, if: :blog_post?
  validates :content, presence: true, if: :blog_post?
  validates :preview, presence: true, if: :blog_post?
  # Twitter post
  validates :content, presence: true, if: :tweet?
  validates :title, presence: true, if: :tweet?

  def self.inheritance_column
    nil
  end

  def blog_post?
    type == "post"
  end

  def tweet?
    type == "tweet"
  end
end
