class BooksController < ApplicationController

    # データベース内の書籍データを取得し、一覧表示させる
    # 非同期検索
    def index
        @books = Book.all
    end

    # indexより選択したデータの詳細ページを表示
    def show
        @book = Book.find(params[:id])
    end

    def search
        if params[:search].present?
            @books = Book.search(params[:search])
        else
            @books = Book.none
        end
    end

    def series
        @series = Series.find(params[:id])
        @books = Book.all.where(series: @series.id).order(release: :asc)
    end
end
