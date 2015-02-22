class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :roles

  before_save :setup_role

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  # Defining default Role as "Registered"
  def setup_role
    if self.role_ids.empty?
      self.role_ids = [2]
    end
  end
end
