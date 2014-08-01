json.array!(@articles) do |article|
  json.extract! article, :id, :title, :content, :excerpt, :category_id, :author_id
  json.url article_url(article, format: :json)
end
