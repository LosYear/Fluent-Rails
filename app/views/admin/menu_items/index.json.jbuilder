json.array!(@menu_items) do |menu_item|
  json.extract! menu_item, :id, :menu_id, :parent_id, :title, :url, :type, :order, :status
  json.url menu_item_url(menu_item, format: :json)
end
