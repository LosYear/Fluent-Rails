class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :title
      t.text :content
      t.integer :author
      t.integer :updater
      t.string :slug

      t.timestamps
    end
  end
end
