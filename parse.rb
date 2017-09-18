# require library
# find url
# open url
# parse url
# search for elements , create array of hashes
# write back to csv

require 'csv'
require 'open-uri'
require 'nokogiri'

# puts "please input your search term"
# search_term = gets.chomp.downcase!


file = open("https://www.tesco.com/groceries/product/search/default.aspx?searchBox=milk&newSort=true&search=Search").read
doc = Nokogiri::HTML(file)


product_range = []

doc.search('.product').each do |product_row|
  description = product_row.css('.desc').text.strip
  price = product_row.css('.linePrice').text.strip
  unit_price = product_row.css('.linePriceAbbr').text.strip

  item = {
    description: description,
    price: price,
    unit_price: unit_price
  }

  product_range << item unless item[:description].empty?
end

puts product_range

CSV.open('products.csv','w') do |csv|
  product_range.each do |item|
    csv << [item[:description], item[:price], item[:unit_price]]
  end
end

