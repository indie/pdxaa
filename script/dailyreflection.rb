require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://www.aa.org/lang/en/aareflections.cfm"
doc = Nokogiri::HTML(open(url))
doc.html("content").each do |content|
  puts content.at_css(".clr").text
end