class Article < ActiveRecord::Base
  has_many :comments
  has_and_belongs_to_many :categories
  # has_paper_trail
  has_attached_file :photo, :styles => { :small => "150x150> "},
                            :url  => "/assets/articles/:id/:style/:basename.:extension",
                            :path => ":rails_root/public/assets/articles/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  has_attached_file :cover_photo, :styles => { :small => "150x150>", :large => "300x300>" },
                                  :url  => "/assets/articles/:id/:style/:basename.:extension",
                                  :path => ":rails_root/public/assets/articles/:id/:style/:basename.:extension",
                                  :default_url => '/images/missing_small.png'
  has_many :pictures, :dependent => :destroy

  searchable do
    text :name, :boost => 5
    text :content, :publish_month
    text :comments do
      comments.map(&:content)
    end
    time :published_at
    string :publish_month
  end

  def publish_month
    published_at.strftime("%B %Y")
  end
end
