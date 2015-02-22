class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.string :title
      t.text :content
      t.string :name
      t.string :type
      t.boolean :status

      t.timestamps
    end
    add_index :blocks, :name, unique: true
  end
end
