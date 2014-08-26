class AddFavoritesCount < ActiveRecord::Migration
  def change
    add_column :articles, :favorites_count, :integer, default: 0, null: false

    Article.reset_column_information
    Article.all.each do |p|
      p.update_attribute :favorites_count, p.favorites.length
    end
  end
end
