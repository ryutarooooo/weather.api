require "open-uri"
require "json"
require "pry"

response = open("http://weather.livedoor.com/forecast/webservice/json/v1?city=471010")
parse_text = JSON.parse(response.read)

result = parse_text["pinpointLocations"]

result_name = result.map { |hash| hash["name"] }

# weather = JSON.pretty_generate(parse_text)

puts result_name[1]
