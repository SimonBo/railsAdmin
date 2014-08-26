class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments
  has_many :favorites
  has_many :favorite_articles, through: :favorites, source: :favorited, source_type: 'Article'

  def to_s
    "#{email}"
  end
end
