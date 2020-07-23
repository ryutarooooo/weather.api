require "date"

# 本日の日付で生成
d1 = Date.today
d2 = d1 + 1

puts %w(日 月 火 水 木 金 土)[d2.wday] + "曜日"
