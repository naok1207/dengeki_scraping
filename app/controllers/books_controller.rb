class BooksController < ApplicationController

    # データベース内の書籍データを取得し、一覧表示させる
    # 非同期検索
    def index
        @book = Book.all
    end

    # indexより選択したデータの詳細ページを表示
    def show
        @book = Book.find(params[:id])
    end
end
