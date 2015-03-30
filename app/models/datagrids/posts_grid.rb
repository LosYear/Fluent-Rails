class Datagrids::PostsGrid
  include Datagrid

  scope do
    Post
  end

  filter(:title, :string)
  filter(:type, :enum, :select => [[I18n.t('backend_part.post_types.post'), 'post'],[I18n.t('backend_part.post_types.tweet'), 'tweet']], :default => 'post')

  column(:title, :header => I18n.t('activerecord.attributes.post.title'))
  column(:slug, :header => I18n.t('activerecord.attributes.post.slug'))
  column(:type, :header => I18n.t('activerecord.attributes.post.type'), :html => true, :order => false) do |record|
    fa_icon case record.type
              when 'post'
                'file-text-o'
              when 'tweet'
                'twitter'
              else
                'question'
            end
  end
  column(:actions, :html => true, :header => I18n.t('backend_part.actions')) do |record|
    link_to(icon('pencil'), edit_admin_post_path(record), 'data-original-title' => t('backend_part.edit'), 'id' => 'tooltip', :data => {:push => true}) +
    link_to(icon('trash'), admin_post_path(record), 'data-original-title' => t('backend_part.remove'), 'id' => 'tooltip',  :method => :delete, :confirm => "#{t("backend_part.confirm")}", :data => {:push => true})
  end

end