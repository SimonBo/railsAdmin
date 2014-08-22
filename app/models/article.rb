class Article < ActiveRecord::Base
  has_many :comments
  belongs_to :author
  has_and_belongs_to_many :categories
  # has_paper_trail
  # has_attached_file :photo, :dependent => :destroy, :styles => { :small => "150x150> "},
  #                           :url  => "/assets/articles/:id/:style/:basename.:extension",
  #                           :path => ":rails_root/public/assets/articles/:id/:style/:basename.:extension"

  # validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  has_attached_file :cover_photo, :styles => { :small => "150x150>", :large => "300x300>", :carousel => "800X500" },
                                  :url  => "/assets/articles/:id/:style/:basename.:extension",
                                  :path => ":rails_root/public/assets/articles/:id/:style/:basename.:extension",
                                  :default_url => 'http://placehold.it/300x300'
  validates_attachment_content_type :cover_photo, :content_type => ['image/jpeg', 'image/png']
  has_many :pictures, :dependent => :destroy

  def self.most_popular
    self.order("visits DESC").limit(3)
  end

end


