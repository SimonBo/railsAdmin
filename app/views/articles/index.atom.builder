atom_feed do |feed|
  feed.title "第1生活"
  feed.updated @articles.maximum(:updated_at)
  
  @articles.each do |article|
    feed.entry article, published: article.created_at do |entry|
      entry.title article.title
      entry.content article.content
      entry.author do |author|
        author.name article.author
      end
    end
  end
end