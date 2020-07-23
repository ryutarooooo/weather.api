require "./methods"

csv_data_okinawa = CSV.read("okinawa_area.csv")
#場所の一覧を表示
residence_list(csv_data_okinawa)
#住んでる場所を選択
select_num = residence_select
#データ取得
result = data_acquisition(csv_data_okinawa, select_num)
#天気予報を発表
weather_forecast_result(result, csv_data_okinawa, select_num)
