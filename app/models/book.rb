class Book < ApplicationRecord

    def self.search(search)
        return nil unless search
        searches = search.split(' ')
        book = Book.all
        searches.each do |search|
            book = book.where(['CONCAT(title, subtitle, detail, series, author, illustrator) LIKE ?', "%#{search}%"])
        end
        return book
    end
end