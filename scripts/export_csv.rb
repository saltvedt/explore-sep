require 'yaml'
require 'pry'
require 'json'


graph = YAML::load_file('data/graph.yml')
titles = YAML::load_file('data/titles.yml')

graph.each do |entry, related_entries|
  puts titles[entry] + ";" + related_entries.map { |r| titles[r]}.join(";")
end

