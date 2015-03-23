class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.text :preview
      t.string :slug
      t.string :type
      t.integer :status

      t.timestamps
    end
  end
end
