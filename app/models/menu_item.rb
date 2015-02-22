class MenuItem < ActiveRecord::Base
  belongs_to :menu
  validates :menu_id, presence: true
  validates :title, presence: true
  validates :url, presence: true

  before_destroy :destroy_children

  private
  def destroy_children
    MenuItem.destroy_all(:parent_id => self.id)
  end
end
