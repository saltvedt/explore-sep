require 'yaml'
require 'pry'
require 'json'

URL = "https://plato.stanford.edu/entries/%s/"

entries = YAML::load_file('data/graph.yml')
titles = YAML::load_file('data/titles.yml')



counts = {}

entries.each do |page, relations|
  relations.each do |relation|
    if counts[relation].nil?
      counts[relation] = 1
    else
      counts[relation] += 1
    end
  end
end

sorted = entries.sort_by { |t, r| r.count }.reverse!

sorted.each do |t,r|
  puts titles[t] + ";" + t + ";" + r.count.to_s + ";" + counts[t].to_s
end


