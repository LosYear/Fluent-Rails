class AddTypeToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :type, :string
  end
end
