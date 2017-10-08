require 'open-uri'
require 'nokogiri'
require 'csv'

host = 'http://funabashi.mypl.net'
dir = '/shop/list?c=2'
url = host+dir

CSV.open("list.csv", "w") do |csv|
csv << ['名称','リンク']
(1..2).each do |i|
  charset = nil
  html = open(url+'&pg='+i.to_s) do |f|
    charset = f.charset
    f.read
  end

  doc = Nokogiri::HTML.parse(html, nil, charset)
  doc.css('article.card_list_article').each do |node|
    p name = node.css('h1').inner_text
    p link = node.css('.card_list_ttl').attribute('href').value
    #詳細ページ
    #d_charset = nil
    #detail = open(host+link) do |f|
    #  d_charset = f.charset
    #  f.read
    #end
    #
    #detail_doc = Nokogiri::HTML.parse(detail, nil, d_charset)
    #p detail_doc.css('#plus').inner_html

    p name = node.css('h1').inner_text
    p link = node.css('.card_list_ttl').attribute('href').value
    csv << [name, link] # csvへの書き込み
  end
end
end
