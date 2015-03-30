class Datagrids::MenusGrid
  include Datagrid

  scope do
    Menu
  end

  filter(:title, :string) do |value|
    query = "%#{value}%"
    self.where('title LIKE :search', search: query)
  end
  filter(:name, :string) do |value|
    query = "%#{value}%"
    self.where('name LIKE :search', search: query)
  end

  column(:name, :header => I18n.t('activerecord.attributes.menu.name'), :html => true) do |record|
    link_to record.name, admin_menu_items_path(:menu_id => record.id), :data => {:push => true}
  end
  column(:title, :header => I18n.t('activerecord.attributes.menu.title'))
  column(:description, :header => I18n.t('activerecord.attributes.menu.description'))
  column(:actions, :html => true, :header => I18n.t('backend_part.actions')) do |record|
    link_to(icon('pencil'), admin_menu_items_path(:menu_id => record.id), 'data-original-title' => t('backend_part.edit'), 'id' => 'tooltip', :data => {:push => true}) +
    link_to(icon('trash'), admin_menu_path(record), 'data-original-title' => t('backend_part.remove'), 'id' => 'tooltip',  :method => :delete, :confirm => "#{t("backend_part.confirm")}", :data => {:push => true})
  end

end