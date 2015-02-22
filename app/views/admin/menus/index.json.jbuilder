json.array!(@menus) do |menu|
  json.extract! menu, :id, :title, :name, :description, :status
  json.url menu_url(menu, format: :json)
end
