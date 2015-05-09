require 'open-uri'

@doc = Nokogiri::HTML(open("http://www.languagedaily.com/learn-german/vocabulary/common-german-words"))
@doc.css("tr[class^=row]").each do |row|
  columns = row.css("td")
  Card.create(original_text: columns[1].content,
              translated_text: columns[2].content)
end
