class AddAttachmentAuthorPhotoToAuthors < ActiveRecord::Migration
  def self.up
    change_table :authors do |t|
      t.attachment :author_photo
    end
  end

  def self.down
    remove_attachment :authors, :author_photo
  end
end
