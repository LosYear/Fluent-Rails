class CreateSocials < ActiveRecord::Migration
  def change
    create_table :socials do |t|
      t.string :title
      t.string :link
      t.integer :order
      t.boolean :status
      t.attachment :logo

      t.timestamps
    end
  end
end
