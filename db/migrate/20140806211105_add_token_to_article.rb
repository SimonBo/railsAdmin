class AddTokenToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :token, :string
  end
end
