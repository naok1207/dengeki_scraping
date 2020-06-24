○取得し、格納するデータ
    タイトル : title : string
    巻数 : number : integer
    著者 : author : string
    イラスト : illustrator : string
    サブタイトル : subtitle : string
    詳細 : detail : text
    ISBN : isbn : integer
    判型 : format : integer
    ページ数 : page : integer
    発売日 : release : datetime
    定価 : price : integer
    出版社 : publisher : string
    url : url : string
    画像 : image : string

コマンド
    $rails g model book title:string number:integer author:string illustrator:string subtitle:string detail:text isbn:integer format:string page:integer release:datetime price:integer publisher:string url:string image:string