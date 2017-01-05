class Post < ApplicationRecord

  validates :author, length: { minimum: 2, maximum: 20 }, presence: true
  validates :text, length: { minimum: 20, maximum: 200 }, presence: true

  belongs_to :category 

  scope :search_by_author, -> (author) { where("(author like ?) OR author in (?)", "%#{author}%", author.split) }

end
