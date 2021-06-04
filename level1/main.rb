require "json"
require "date"

 
file = File.read('input.json')
datas = JSON.parse(file)

result = Hash.new
result["rentals"] = []


datas["rentals"].each do |rental|

    number_of_rental_days = ( (DateTime.parse(rental['end_date']).to_time - DateTime.parse(rental['start_date']).to_time) / (24*3600) ).to_i + 1
    car_s_price_per_day = "#{datas["cars"][rental['car_id']-1]['price_per_day']}".to_i
    time_component = number_of_rental_days * car_s_price_per_day

    number_of_km = rental['distance']
    car_s_price_per_km = "#{datas["cars"][rental['car_id']-1]['price_per_km']}".to_i
    distance_component = number_of_km * car_s_price_per_km

    rental_price = time_component + distance_component


    rental_price_per_car = Hash.new
    rental_price_per_car["id"] = rental['id']
    rental_price_per_car["price"] = rental_price 

    result["rentals"] << rental_price_per_car 
end



File.open("output.json","w") do |f|
    f.write(result.to_json)
end
 