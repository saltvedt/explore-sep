require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'
require 'yaml'

IDENTIFIERS_FILE = "data/identifiers.yml"
URL = "https://plato.stanford.edu/contents.html"

contents = Nokogiri::HTML(open(URL))

identifiers = contents.css("#content li a").map { |a| a.attr("href") }

identifiers.map! do |t|
  t.gsub("entries/", "").gsub("/", "")
end

identifiers.uniq!

File.open(IDENTIFIERS_FILE, 'w') { |f| f.write identifiers.to_yaml }

