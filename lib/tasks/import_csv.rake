require 'csv'

namespace :import_csv do
  desc 'Import cities'
  task cities: :environment do
    list = []
    CSV.foreach('db/csv/cities.csv') do |row|
      list << {
        name: row[0],
        location_id: row[1],
      }
    end

    puts 'start creating cities'
    begin
      City.create!(list)
      puts 'completed!'
    rescue ActiveModel::UnknownAttributeError
      puts 'raised error: unknown attributes'
    end
  end

end
