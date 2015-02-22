class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.integer :menu_id
      t.integer :parent_id
      t.string :title
      t.string :url
      t.string :type
      t.integer :order
      t.boolean :status

      t.timestamps
    end
  end
end
