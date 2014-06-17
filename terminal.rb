require_relative './lib/ad_predictor.rb'
require 'shellwords'

db = AdPredictor.db

input = ""

def menu
  puts "\n\nInput options:\n\n"
  puts "clear - clear database"
  puts "import file/path/file.csv - import CSV"
  puts "ad hour 'browser' 'platform' 'region' - suggest ad. Type 'x' for no preference."
  puts "menu - show this menu again"
  puts "quit\n\n"
end
menu

while input[0] != "quit"
  print "Input: "

  input = Shellwords.split(gets.chomp)
  input.map { |input| input.gsub("'", "") }

  case input[0]
  when "clear"
    db.clear
    puts "Database cleared.\n\n"
  when "menu"
    menu
  when "import"
    result = AdPredictor::ImportCSV.run(path: input[1])
    if result.error
      puts result.error.to_s + "\n\n"
    else
      puts "#{result.records_imported} records imported.\n\n"
      puts "#{result.records_rejected} records rejected.\n\n"
    end
  when "ad"
    params = {}
    params[:hour] = input[1] unless input[1] == 'x' || input[1].nil?
    params[:browser] = input[2] unless input[2] == 'x' || input[2].nil?
    params[:platform] = input[3] unless input[3] == 'x' || input[3].nil?
    params[:region] = input [4] unless input [4] == 'x' || input[4].nil?
    result = AdPredictor::GetAd.run(params)
    if result.error
      puts result.error + "\n\n"
    else
      puts "Suggested ad: #{result.ad}"
      puts "Expected clickthrough: #{(result.clickthrough * 100).round(2)}%\n\n"
    end
  end
end


