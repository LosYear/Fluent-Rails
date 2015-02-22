class AddStatusToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :status, :bool
  end
end
