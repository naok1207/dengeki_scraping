require "#{Rails.root}/lib/scraping_book"

namespace :scraping do
  desc "電撃文庫の書籍情報取得"
  task fetch_dengeki: :environment do
    p "スクレイピングを開始しました。"
    ScrapingBook.sample_function
    url = 'https://dengekibunko.jp/product/oreimo/321907000708.html'
    doc = ScrapingBook.get_book_doc(url)
    book_hash = ScrapingBook.fetch_book(url, doc)
    if book = Book.find_by(url: url)
      book.update(book_hash)
    elsif
      Book.create!(book_hash)
    end
  end

end
