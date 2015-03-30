class Datagrids::UsersGrid
  include Datagrid

  scope do
    User
  end

  filter(:email, :string) do |value|
    query = "%#{value}%"
    self.where('email LIKE :search', search: query)
  end

  column(:id, :header => '#')
  column(:email, :header => I18n.t('activerecord.attributes.user.email'), :html => true) do |record|
    link_to record.email, edit_admin_user_path(record), :data => {:push => true}
  end
  column(:created_at, :header => I18n.t('activerecord.attributes.user.created_at'))
  column(:actions, :html => true, :header => I18n.t('backend_part.actions')) do |record|
    link_to(icon('pencil'), edit_admin_user_path(record), 'data-original-title' => t('backend_part.edit'), 'id' => 'tooltip', :data => {:push => true}) +
    link_to(icon('trash'), admin_user_path(record), 'data-original-title' => t('backend_part.remove'), 'id' => 'tooltip',  :method => :delete, :confirm => "#{t("backend_part.confirm")}", :data => {:push => true})
  end

end