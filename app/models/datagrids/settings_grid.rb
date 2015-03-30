class Datagrids::SettingsGrid
  include Datagrid

  scope do
    Setting.unscoped
  end

  filter(:var, :string) do |value|
    query = "%#{value}%"
    self.where('var LIKE :search', search: query)
  end

  column(:var, :header => I18n.t('activerecord.attributes.setting.name'), :html => true) do |record|
    link_to record.var, edit_admin_setting_path(record), :data => {:push => true}
  end
  column(:value, :header => I18n.t('activerecord.attributes.setting.value'))
  column(:actions, :html => true, :header => I18n.t('backend_part.actions')) do |record|
    link_to(icon('pencil'), edit_admin_setting_path(record), 'data-original-title' => t('backend_part.edit'), 'id' => 'tooltip', :data => {:push => true}) +
    link_to(icon('trash'), admin_setting_path(record), 'data-original-title' => t('backend_part.remove'), 'id' => 'tooltip',  :method => :delete, :confirm => "#{t("backend_part.confirm")}", :data => {:push => true})
  end

end