json.array!(@blocks) do |block|
  json.extract! block, :id, :title, :content, :name, :type, :status
  json.url block_url(block, format: :json)
end
