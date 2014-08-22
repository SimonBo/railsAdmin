class AddCommentsCountToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :comments_count, :integer, default: 0, null: false

    Article.find_each do |article|
      Article.reset_counters(article.id, :comments)
    end
   
  end
end


