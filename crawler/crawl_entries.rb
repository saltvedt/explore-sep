require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'
require 'yaml'

URL = "https://plato.stanford.edu/entries/%s/"
IDENTIFIERS_FILE = "data/identifiers.yml"
GRAPH_FILE = "data/graph.yml"
TITLE_FILE = "data/titles.yml"

pages_to_crawl = YAML::load_file(IDENTIFIERS_FILE) rescue {}
titles = YAML::load_file(TITLE_FILE) rescue {}

graph_data = {}

while !pages_to_crawl.empty?
  entry = pages_to_crawl.pop

  puts "Fetching #{entry}"
  page = Nokogiri::HTML(open(URL % entry))

  # Store title
  title = page.css("h1").text
  titles[entry] = title
  File.open(TITLE_FILE, 'w') { |f| f.write titles.to_yaml }

  # Store related entries
  related = page.css("#related-entries p a").map { |a| a.attr("href") }
  cleaned_related = related.map do |r|
    r.gsub("../", "").gsub("/", "")
  end

  graph_data[entry] = cleaned_related
  File.open(GRAPH_FILE, 'w') { |f| f.write graph_data.to_yaml }
end
