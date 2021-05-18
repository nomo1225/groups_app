namespace :api_weather do
  desc 'OPEN_WEATHER_APIから天気情報取得・保存'
  task create_or_update_weather: :environment do
    City.all.each do |city|
      url = "https://api.openweathermap.org/data/2.5/weather"
      url << "?id=#{city.location_id}"
      url << "&appid=#{ENV['OPEN_WEATHER_API_KEY']}"
      url << "&units=metric" #温度を摂氏に
      client = HTTPClient.new #インスタンス生成
      response = client.get(url) #GETリクエスト
      hash =JSON.load(response.body).to_a  #JSON形式からhashへ
      @weather_main = hash[1][1][0]['main']
      @temp_min     = hash[3][1]['temp_min'].round
      @temp_max     = hash[3][1]['temp_max'].round
      if Weather.find_by(location_id: city.location_id)
        Weather.update(weather_main: @weather_main, temp_min: @temp_min, temp_max: @temp_max, location_id: city.location_id)
      else
        Weather.create(weather_main: @weather_main, temp_min: @temp_min, temp_max: @temp_max, location_id: city.location_id)
      end
    end
  end
end