require "json"
require "date"

 
file = File.read('input.json')
datas = JSON.parse(file)

result = Hash.new
result["rentals"] = []


datas["rentals"].each do |rental|

    number_of_rental_days = ( (DateTime.parse(rental['end_date']).to_time - DateTime.parse(rental['start_date']).to_time) / (24*3600) ).to_i + 1
    car_s_price_per_day = "#{datas["cars"][rental['car_id']-1]['price_per_day']}".to_i

    # decreasing pricing for longer rentals constant
    small = car_s_price_per_day - (car_s_price_per_day * 10 / 100)
    middle = car_s_price_per_day - (car_s_price_per_day * 30 / 100)
    big = car_s_price_per_day / 2

    n = number_of_rental_days


    case n
    when 1
        time_component = car_s_price_per_day
    when 2..4
        time_component = (n - 1) * small + car_s_price_per_day
    when 5..10
        time_component = (n - 4) * middle + 3 * small + car_s_price_per_day 
    when 11..
        time_component = (n - 10) * big + 6 * middle + 3 * small + car_s_price_per_day 
    end


    number_of_km = rental['distance']
    car_s_price_per_km = "#{datas["cars"][rental['car_id']-1]['price_per_km']}".to_i
    distance_component = number_of_km * car_s_price_per_km

    rental_price = time_component + distance_component

    
    #============ 30 % COMMISSION =================


    commission = rental_price * 30 / 100

    insurance_fee = commission / 2
    assistance_fee = number_of_rental_days * 100
    drivy_fee = commission - insurance_fee - assistance_fee


    #============ 

    driver = Hash.new
    driver['who'] = "driver"
    driver['type'] = "debit"
    driver['amount'] = rental_price

    owner = Hash.new
    owner['who'] = "owner"
    owner['type'] = "credit"
    owner['amount'] = rental_price - commission

    insurance = Hash.new
    insurance['who'] = "insurance"
    insurance['type'] = "credit"
    insurance['amount'] = insurance_fee 

    assistance = Hash.new
    assistance['who'] = "assistance"
    assistance['type'] = "credit"
    assistance['amount'] = assistance_fee

    drivy = Hash.new
    drivy['who'] = "drivy"
    drivy['type'] = "credit"
    drivy['amount'] = drivy_fee

    #============ 

    rental_price_per_car = Hash.new
    rental_price_per_car["id"] = rental['id']
    rental_price_per_car["actions"] = [driver, owner, insurance, assistance, drivy]




    result["rentals"] << rental_price_per_car





end



File.open("output.json","w") do |f|
    f.write(result.to_json)
end