class Datagrids::BlocksGrid
  include Datagrid

  scope do
    Block
  end

  filter(:title, :string) do |value|
    query = "%#{value}%"
    self.where('title LIKE :search', search: query)
  end
  filter(:name, :string) do |value|
    query = "%#{value}%"
    self.where('name LIKE :search', search: query)
  end

  column(:name, :header => I18n.t('activerecord.attributes.block.name'), :html => true) do |record|
    link_to record.name, edit_admin_block_path(record), :data => {:push => true}
  end
  column(:title, :header => I18n.t('activerecord.attributes.block.title'))
  column(:actions, :html => true, :header => I18n.t('backend_part.actions')) do |record|
    link_to(icon('pencil'), edit_admin_block_path(record), 'data-original-title' => t('backend_part.edit'), 'id' => 'tooltip', :data => {:push => true}) +
    link_to(icon('trash'), admin_block_path(record), 'data-original-title' => t('backend_part.remove'), 'id' => 'tooltip',  :method => :delete, :confirm => "#{t("backend_part.confirm")}", :data => {:push => true})
  end

end