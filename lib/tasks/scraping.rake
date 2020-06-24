namespace :scraping do
  desc "電撃文庫の書籍情報取得"
  task fetch_dengeki: :environment do
    p "スクレイピングを開始しました。"
  end

end
