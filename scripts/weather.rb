#!/usr/bin/env ruby
#encoding: utf-8

APPID = "22f7c830d6fad6c0a48b10aedc5a8500"

require 'open-uri'
require 'json'

data = open('http://ip-api.com/json')
location = JSON.parse data.read

data = open("http://api.openweathermap.org/data/2.5/weather?lat=#{location['lat']}&lon=#{location['lon']}&units=metric&APPID=#{APPID}")
data_hash = JSON.parse data.read

city = location["city"]
weather_id = data_hash.dig('weather', 0, 'id')
temp = data_hash.dig('main', 'temp')
humd = data_hash.dig('main', 'humidity')

case weather_id
when 200..299
  weather_icon = ""
when 300..399
  weather_icon = ""
when 500..599
  weather_icon = ""
when 600..699
  weather_icon = ""
when 700..799
  weather_icon = ""
when 800
  weather_icon = ""
when 801..899
  weather_icon = ""
end

puts "#{weather_icon} [#{city}: #{temp.to_i}°]"