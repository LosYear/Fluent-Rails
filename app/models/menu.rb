class Menu < ActiveRecord::Base
  has_many :menu_items, -> {order('`order` ASC')}, dependent: :destroy

  @_tree = Hash.new

  def tree(params = {})
    @tree = Hash.new

    # Array by parent's ids
    items_sorted_by_parent_id = sort_by_parent_id params

    form_tree(items_sorted_by_parent_id, 0)

    @_tree
  end

  def admin_collection
    @_tree = Hash.new
    @_tree[I18n.t('backend_part.no_parent')] = 0

    form_list(sort_by_parent_id, 0, 0)

    @_tree
  end

  private

  def form_tree items, parent_id
    unless @_tree.instance_of? Hash
      @_tree = Hash.new
    end
    if items.has_key? parent_id
      items[parent_id].each do |item|
        info = {:title => item.title, :url => item.url, :order => item.order, :id => item.id, :data_push => item.data_push}
        if parent_id == 0
          @_tree[item.id] = info
        else
          unless @_tree[parent_id].has_key? :items
            @_tree[parent_id][:items] = Hash.new
          end

          @_tree[parent_id][:items][item.id] = info
        end

        form_tree(items, item.id)
      end
    end
  end

  def form_list(items, parent_id, level)
    unless @_tree.instance_of? Hash
      @_tree = Hash.new
    end
    if items.has_key? parent_id
      items[parent_id].each do |item|
        level += 1

        title = '-' * level
        title += ' ' + item.title

        @_tree[title] = item.id
        form_list(items, item.id, level)
        level -= 1
      end
    end
  end

  def sort_by_parent_id params = {}
    items_sorted_by_parent_id = Hash.new
    items = ''

    if params.empty?
      items = self.menu_items
    else
      items = self.menu_items.where(params)
    end

    items.each do |item|
      unless items_sorted_by_parent_id.has_key? item.parent_id
        items_sorted_by_parent_id[item.parent_id] = Array.new
      end

      items_sorted_by_parent_id[item.parent_id].push item
    end

    items_sorted_by_parent_id
  end
end
