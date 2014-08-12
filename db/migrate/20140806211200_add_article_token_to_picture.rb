class AddArticleTokenToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :article_token, :string
  end
end
