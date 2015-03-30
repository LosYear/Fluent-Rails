class Datagrids::SocialsGrid
  include Datagrid

  scope do
    Social
  end

  filter(:title, :string) do |value|
    query = "%#{value}%"
    self.where('title LIKE :search', search: query)
  end

  column(:title, :header => I18n.t('activerecord.attributes.social.title'), :html => true) do |record|
    link_to record.title, edit_admin_social_path(record), :data => {:push => true}
  end
  column(:link, :header => I18n.t('activerecord.attributes.social.link'))
  column(:status, :header => I18n.t('activerecord.attributes.social.status'), :order => false, :html => true) do |record|
    icon (record.status ? 'eye-open' : 'eye-close')
  end
  column(:actions, :html => true, :header => I18n.t('backend_part.actions')) do |record|
    link_to(icon('pencil'), edit_admin_social_path(record), 'data-original-title' => t('backend_part.edit'), 'id' => 'tooltip', :data => {:push => true}) +
    link_to(icon('trash'), admin_social_path(record), 'data-original-title' => t('backend_part.remove'), 'id' => 'tooltip',  :method => :delete, :confirm => "#{t("backend_part.confirm")}", :data => {:push => true})
  end

end