require "#{Rails.root}/lib/scraping_book"

namespace :scraping do
  desc "電撃文庫の書籍情報取得"
  task fetch_dengeki: :environment do
    p "スクレイピングを開始しました。"
    ScrapingBook.sample_function
    default_url = "https://dengekibunko.jp/product"
    
    178.times do |i|
      if i == 1
        books_url = default_url
      else
        books_url = "#{default_url}/page/#{i}"
      end
      books_doc = ScrapingBook.get_book_doc(books_url)
      paths = books_doc.search('//h2[contains(@class, "p-books-media__title")]/a').map {|a| a[:href] }
      # puts paths
      paths.each do |path|
        sleep(1)
        url = path
        doc = ScrapingBook.get_book_doc(url)
        book_hash = ScrapingBook.fetch_book(url, doc)
        if book = Book.find_by(url: url)
          book.update(book_hash)
        elsif
          Book.create!(book_hash)
        end
        p book_hash[:title]
      end
    end
  end

end
