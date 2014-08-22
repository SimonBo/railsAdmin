class AddVisitsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :visits, :integer, null: false, default: 0
  end
end
