class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :title
      t.string :name
      t.string :description
      t.boolean :status

      t.timestamps
    end
    add_index :menus, :name, unique: true
  end
end
