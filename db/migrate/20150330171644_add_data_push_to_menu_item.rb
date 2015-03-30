class AddDataPushToMenuItem < ActiveRecord::Migration
  def change
    add_column :menu_items, :data_push, :boolean
  end
end
