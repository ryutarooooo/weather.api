#場所の一覧を表示
# residence_list
#住んでる場所を選択
# residence_select
#データ取得
# data_acquisition
#天気予報を発表
# weather_forecast_result

require "open-uri"
require "json"
require "csv"
require "date"
require "pry"

csv_data = CSV.read("okinawa_area.csv")

def residence_list
  puts <<~TEXT
         1,那覇,471010
         2,名護,471020
         3,久米島,471030
         4,南大東,472000
         5,宮古島,473000
         6,石垣島,474010
         7,与那国島,474020
         
       TEXT
end

#--------------------

def residence_select
  while true
    print "住んでる地域を選択してください>"
    num = gets.to_i
    break if num >= 1 && num <= 7
  end
  # area_num = array[num - 1][2].to_i
  num
end

#--------------------
def data_acquisition(csv_data, num)
  response = open("http://weather.livedoor.com/forecast/webservice/json/v1?city=#{csv_data[num - 1][2].to_i}")

  parse_text = JSON.parse(response.read)

  # result1 = parse_text["pinpointLocations"]

  parse_text["forecasts"]
end

#-------------------
def weather_forecast_result(result, csv_data, num)
  puts "[-----明日の天気予報-----]"
  #明日の日にち
  # t = Time.new
  # str = t.strftime("%Y年%m月%d日")
  # str  # 2017-04-25 21:45:06
  d1 = Date.today
  d2 = d1 + 1
  wdays = %w(日 月 火 水 木 金 土)[d2.wday] + "曜日"

  result[0]["date"]
  puts "明日は#{d2}.#{wdays}です"
  #場所と天気
  tomorrow_climate = csv_data[num - 1][1]
  tomorrow_weather = result[0]["telop"]
  puts "#{tomorrow_climate}の天気は#{tomorrow_weather}です"

  if tomorrow_weather.include?("雨")
    puts "雨の可能性が有ります注意してください"
  else
    puts "ランニング日和です"
  end
  #明日の気温
  tomorrow_temperature = (result[1]["temperature"]["max"]["celsius"]).to_i

  puts "明日の気温は#{tomorrow_temperature}度です。"

  if tomorrow_temperature > 10
    puts "寒いので厚着した方がいいと思います。"
  elsif tomorrow_temperature <= 20
    puts "肌寒いので長袖がいいと思います。"
  elsif tomorrow_temperature > 20
    puts "暑いので半袖で大丈夫だと思います。"
  end

  puts "明日もランニング頑張ってください!!!"
end

#-------------------

residence_list

num = residence_select

result = data_acquisition(csv_data, num)

weather_forecast_result(result, csv_data, num)
