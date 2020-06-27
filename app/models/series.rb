class Series < ApplicationRecord
    has_many :book_series_relations
    has_many :books, through: :book_series_relations
end
