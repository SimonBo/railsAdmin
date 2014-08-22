class Author < ActiveRecord::Base
  has_many :articles

  has_attached_file :author_photo, :styles => { :small => "150x150>", :large => "300x300>", :v_small => "75x75" },
                                   :default_url => 'http://placehold.it/150x150'
                    
  validates_attachment :author_photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  def to_s
    "#{first_name} #{last_name}"
  end
end
