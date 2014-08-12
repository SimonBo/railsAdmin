class Category < ActiveRecord::Base
  has_and_belongs_to_many :articles

    validates :name, presence: true, length: { in: 2..20 }, uniqueness: true

  has_paper_trail
end
