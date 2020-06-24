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

    def self.fetch_work(url, doc)
        return {
            title: title(doc),
            number: number(doc),
            author: author(doc),
            illustrator: illusrator(doc),
            subtitle: subtitle(doc),
            detail: detail(doc),
            isbs: isbs(doc),
            format: format(doc),
            page: page(doc),
            release: datetime(doc),
            price: price(doc),
            publisher: '電撃文庫',
            url: url,
            image: image(doc)
        }
    end

    def self.title(doc)
        doc.at('/html/body/div/main/div/div/div/div[1]/div[1]/div/div[1]/div[1]/div[2]/div[1]/div/h1').text.strip
    end

    def self.number(doc)
        title = title(doc)
        return title =~ /\A[0-9]+\z/ ? title : nil
    end

    def self.author(doc)
        doc.at('/html/body/div/main/div/div/div/div[1]/div[1]/div/div[1]/div[1]/div[2]/div[1]/div/ul/li[1]/a').text.strip
    end

    def self.illusrator(doc)
        doc.at('/html/body/div/main/div/div/div/div[1]/div[1]/div/div[1]/div[1]/div[2]/div[1]/div/ul/li[2]/a').text.strip
    end

    def self.subtitle(doc)
        doc.at('/html/body/div/main/div/div/div/div[1]/div[1]/div/div[1]/div[1]/div[2]/p').text.strip
    end

    def self.detail(doc)
        doc.at('/html/body/div/main/div/div/div/div[1]/div[1]/div/div[1]/div[1]/div[2]/div[2]/p[3]').text.strip
    end

    def self.isbn(doc)
        doc.at('/html/body/div/main/div/div/div/div[1]/div[1]/div/div[1]/div[1]/div[2]/table/tbody/tr[1]/td').text.strip.to_i
    end

    def self.format(doc)
        doc.at('/html/body/div/main/div/div/div/div[1]/div[1]/div/div[1]/div[1]/div[2]/table/tbody/tr[2]/td').text.strip
    end

    def self.page(doc)
        doc.at('/html/body/div/main/div/div/div/div[1]/div[1]/div/div[1]/div[1]/div[2]/table/tbody/tr[3]/td').text.strip.to_i
    end

    def self.release(doc)
        date_str = doc.at('//section[contains(@class, "toplevel_information")]//table/tbody/tr[4]/td').text
        date_str = "2000年1月1日" unless date_str.match(/\A\d{4}年\d{1,2}月\d{1,2}日\z/) 
        Date.strptime(date_str, "%Y年%m月%d日")
    end

    def self.price(doc)
        price_text = doc.at('/html/body/div/main/div/div/div/div[1]/div[1]/div/div[1]/div[1]/div[2]/table/tbody/tr[5]/td').text.strip
        price =  price_text =~ /\A[0-9]+\z/ ? price_text : nil
        return price.to_i
    end

    def self.image(doc)
        doc.at('/html/body/div/main/div/div/div/div[1]/div[1]/div/div[1]/div[1]/div[1]/img/src').text.strip
    end
end