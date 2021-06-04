# Mon Brouillon

require "json"
require "date"

 
file = File.read('input.json')
datas = JSON.parse(file)
 
datas["cars"].each do |product|
  puts "#{ product['id'] } #{ product['price_per_day'] } #{ product['price_per_km'] }"
end

# https://openclassrooms.com/forum/sujet/extraire-et-exploiter-donnees-json-ruby


p "#{datas["cars"][0]['price_per_day']}"


datas["rentals"].each do |rentals|
  p  number_of_rental_days = (DateTime.parse(rentals['end_date']).to_time  - DateTime.parse(rentals['start_date']).to_time) / (24*3600)
end


    #A time component: the number of rental days multiplied by the car's price per day
    #A distance component: the number of km multiplied by the car's price per km


    

    p "#{datas["cars"][datas["rentals"][0]['car_id']-1]['price_per_day']}"
    p "#{datas["cars"][datas["rentals"][0]['car_id']-1]['price_per_day']}".to_i