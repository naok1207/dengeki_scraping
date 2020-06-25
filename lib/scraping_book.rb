module ScrapingBook
    # 電撃文庫用モジュール
    def self.sample_function
        p "モジュールが正しく読み込まれています。"
    end

    def self.get_book_doc(url)
        user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36"
        f = OpenURI.open_uri(url, { read_timeout: 300, "User-Agent" => user_agent })
        file = f.read.gsub(/<br>/, "\n")
        Nokogiri::HTML.parse(file, nil, "utf-8")
    end

    def self.fetch_book(url, doc)
        return {
            title: title(doc),
            number: number(doc),
            author: author(doc),
            illustrator: illusrator(doc),
            subtitle: subtitle(doc),
            detail: detail(doc),
            isbn: isbn(doc),
            format: format(doc),
            page: page(doc),
            release: release(doc),
            price: price(doc),
            publisher: '電撃文庫',
            url: url,
            image: image(doc),
            series: series(doc)
        }
    end

    def self.title(doc)
        doc.at('//h1[contains(@class, "p-books-media__title")]').text.strip
    end

    def self.number(doc)
        number = title(doc).delete("^０-９0-9")
        number = number.tr("０-９", "0-9")
        number.to_i
    end

    def self.author(doc)
        author = doc.at('//ul[contains(@class, "p-books-media__authors")]/li[1]/a')
        author ? author.text.strip : nil
    end

    def self.illusrator(doc)
        illustrator = doc.at('//ul[contains(@class, "p-books-media__authors")]/li[2]/a')
        illustrator ? illustrator.text.strip : nil
    end

    def self.subtitle(doc)
        subtitle = doc.at('//p[contains(@class, "p-books-media__lead")]')
        subtitle ? subtitle.text.strip : nil
    end

    def self.detail(doc)
        detail = doc.at('//p[contains(@class, "p-books-media02__detail")]')
        detail ? detail.text.strip : nil
    end

    def self.isbn(doc)
        doc.at('//div[contains(@class, "media-body p-books-media02__contents")]//tr[1]/td').text.delete("^0-9").to_i
    end

    def self.format(doc)
        doc.at('//div[contains(@class, "media-body p-books-media02__contents")]//tr[2]/td').text.strip
    end

    def self.page(doc)
        doc.at('//div[contains(@class, "media-body p-books-media02__contents")]//tr[3]/td').text.delete("^0-9").to_i
    end

    def self.release(doc)
        date_str = doc.at('//div[contains(@class, "p-books-media02__contents")]//tr[4]/td').text
        Date.strptime(date_str, "%Y年%m月%d日")
    end

    def self.price(doc)
        doc.at('//div[contains(@class, "p-books-media02__contents")]//tr[5]/td').text.delete("^0-9").to_i
    end

    def self.image(doc)
        doc.at('//img[contains(@class, "p-books-media02__img")]')[:src]
    end

    def self.series(doc)
        title = doc.at('//a[contains(@class, "p-books-media__series-name")]')
        title ? title.text.strip : nil
    end
end