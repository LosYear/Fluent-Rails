class Datagrids::PagesGrid
  include Datagrid

  scope do
    Page
  end

  filter(:title, :string) do |value|
    query = "%#{value}%"
    self.where('title LIKE :search', search: query)
  end
  filter(:slug, :string) do |value|
    query = "%#{value}%"
    self.where('slug LIKE :search', search: query)
  end

  column(:title, :header => I18n.t('activerecord.attributes.page.title'), :html => true) do |record|
    link_to record.title, edit_admin_page_path(record), :data => {:push => true}
  end
  column(:slug, :header => I18n.t('activerecord.attributes.page.slug'))
  column(:actions, :html => true, :header => I18n.t('backend_part.actions')) do |record|
    link_to(icon('pencil'), edit_admin_page_path(record), 'data-original-title' => t('backend_part.edit'), 'id' => 'tooltip', :data => {:push => true}) +
    link_to(icon('trash'), admin_page_path(record), 'data-original-title' => t('backend_part.remove'), 'id' => 'tooltip',  :method => :delete, :confirm => "#{t("backend_part.confirm")}", :data => {:push => true})
  end

end