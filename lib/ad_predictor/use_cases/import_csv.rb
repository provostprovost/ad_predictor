require 'csv'
require 'date'
require 'pry'

module AdPredictor
  class ImportCSV < UseCase
    def run(inputs)
      return failure(:not_a_csv) if inputs[:path][-4..-1] != ".csv"

      return failure(:file_not_found) if !File.exists?(inputs[:path])

      csv = CSV.read(inputs[:path])

      db = AdPredictor.db

      records_imported = 0
      records_rejected = 0

      csv.each do |row|
        date = Date.parse(row[0]) rescue nil
        hour = Integer(row[1]) rescue nil
        hour = nil if hour && (hour > 23 || hour < 0)
        ad = row[2]
        browser = row[3]
        platform = row[4]
        region = row[5]
        clicked = Integer(row[6]) rescue nil
        if clicked == 1
          clicked = true
        elsif clicked == 0
          clicked = false
        else
          clicked = nil
        end

        if date && hour && ad && browser && platform && region && !clicked.nil?
          db.create_impression(
            date: date,
            hour: hour,
            ad: ad,
            browser: browser,
            platform: platform,
            region: region,
            clicked: clicked )
          records_imported += 1
        else
          records_rejected += 1
        end
      end
      success records_imported: records_imported, records_rejected: records_rejected
    end
  end
end
