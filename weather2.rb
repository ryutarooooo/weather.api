#場所の一覧を表示
# residence_list
#住んでる場所を選択
# residence_select
#データ取得
# data_acquisition
#天気予報を発表
# weather_forecast_result

#提出用
require "open-uri"
require "json"
require "csv"
require "date"
require "pry"

csv_data_okinawa = CSV.read("okinawa_area.csv")

---------------------def residence_list(csv_data_okinawa)
  csv_data_okinawa.each.with_index(1) do |place, i|
    puts "No.#{i}, #{place[1]}"
  end
end

#--------------------

def residence_select
  while true
    print "住んでる地域を選択してください>"
    select_num = gets.to_i
    break if select_num >= 1 && select_num <= 7
  end

  select_num
end

#--------------------

def data_acquisition(csv_data_okinawa, select_num)
  response = open("http://weather.livedoor.com/forecast/webservice/json/v1?city=#{csv_data_okinawa[select_num - 1][2].to_i}")

  parse_text = JSON.parse(response.read)

  parse_text["forecasts"]
end

#-------------------

def weather_forecast_result(result, csv_data_okinawa, select_num)
  puts "[-----明日の天気予報-----]"

  today = Date.today
  tomorrow = today + 1
  tomorrow_wdays = %w(日 月 火 水 木 金 土)[tomorrow.wday] + "曜日"

  result[0]["date"]
  puts "明日は#{tomorrow}.#{tomorrow_wdays}です"

  tomorrow_climate = csv_data_okinawa[select_num - 1][1]
  tomorrow_weather = result[0]["telop"]
  puts "#{tomorrow_climate}の天気は#{tomorrow_weather}です"

  if tomorrow_weather.include?("雨")
    puts "雨の可能性が有ります注意してください"
  else
    puts "ランニング日和です"
  end

  tomorrow_temperature = (result[1]["temperature"]["max"]["celsius"]).to_i

  puts "明日の気温は#{tomorrow_temperature}度です。"

  if tomorrow_temperature < 10
    puts "寒いので厚着した方がいいと思います。"
  elsif tomorrow_temperature <= 20
    puts "肌寒いので長袖がいいと思います。"
  elsif tomorrow_temperature > 20
    puts "暑いので半袖で大丈夫だと思います。"
  end

  puts "明日もランニング頑張ってください!!!"
end

#-------------------

residence_list(csv_data_okinawa)

select_num = residence_select

result = data_acquisition(csv_data_okinawa, select_num)

weather_forecast_result(result, csv_data_okinawa, select_num)
