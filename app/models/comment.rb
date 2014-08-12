class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  has_paper_trail
end
