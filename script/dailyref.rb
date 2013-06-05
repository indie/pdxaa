require 'rubygems'
require 'crack'
require 'open-uri'
require 'rest-client'

url='http://www.aa.org/lang/en/aareflections.cfm'

puts Crack::JSON.parse(RestClient.get(url))

