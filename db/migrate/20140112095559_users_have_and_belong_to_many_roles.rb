
class UsersHaveAndBelongToManyRoles < ActiveRecord::Migration
  def change
    create_table :roles_users, :id => false do |t|
      t.references :role, :user
    end
  end

  def self.down
    drop_table :roles_users
  end
end