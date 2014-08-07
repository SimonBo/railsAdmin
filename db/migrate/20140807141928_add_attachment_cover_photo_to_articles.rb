class AddAttachmentCoverPhotoToArticles < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.attachment :cover_photo
    end
  end

  def self.down
    remove_attachment :articles, :cover_photo
  end
end
