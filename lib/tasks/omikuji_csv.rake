require 'csv'

namespace :omikuji_csv do
  desc 'Import omikujis'
  task omikujis: :environment do
    list = []
    CSV.foreach('db/csv/omikuji.csv') do |row|
      list << {
        result: row[0],
        content: row[1],
      }
    end

    puts 'start creating omikujis'
    begin
      Omikuji.create!(list)
      puts 'completed!'
    rescue ActiveModel::UnknownAttributeError
      puts 'raised error: unknown attributes'
    end
  end

end