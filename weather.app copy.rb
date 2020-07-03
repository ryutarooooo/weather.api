require "open-uri"
require "json"
require "csv"
require "pry"

puts <<~TEXT
       1,那覇
       2,名護
       3,久米島
       4,南大東
       5,宮古島
       6,石垣島
       7,与那国島
     TEXT

array = CSV.read("okinawa_area.csv")
print "住んでる地域を選択してください>"

num = gets.to_i - 1

area_num = array[num][2].to_i

response = open("http://weather.livedoor.com/forecast/webservice/json/v1?city=#{area_num}")

parse_text = JSON.parse(response.read)

result1 = parse_text["pinpointLocations"]

result2 = parse_text["forecasts"]

puts "[-----明日の天気予報-----]"

t = Time.new
str = t.strftime("%Y年%m月%d日")
str  # 2017-04-25 21:45:06
result2[0]["date"]
puts "明日は#{str}です"

tomorrow_climate = array[num][1]
tomorrow_weather = result2[0]["telop"]
puts "#{tomorrow_climate}の天気は#{tomorrow_weather}です"

if tomorrow_weather.include?("雨")
  puts "雨の可能性が有ります注意してください"
else
  puts "ランニング日和です"
end

tomorrow_temperature = (result2[1]["temperature"]["max"]["celsius"]).to_i

puts "明日の気温は#{tomorrow_temperature}度です。"

if tomorrow_temperature > 10
  puts "寒いので厚着した方がいいと思います。"
elsif tomorrow_temperature <= 20
  puts "肌寒いので長袖がいいと思います。"
elsif tomorrow_temperature > 20
  puts "暑いので半袖で大丈夫だと思います。"
end

puts "明日もランニング頑張ってください!!!"
