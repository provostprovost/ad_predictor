require_relative './lib/ad_predictor.rb'
require 'shellwords'

db = AdPredictor.db

input = ""

def menu
  puts "\n\nInput options:\n\n"
  puts "clear - clear database"
  puts "import ./filename.csv - import CSV"
  puts "ad hour 'browser' 'platform' 'region' - suggest ad. Type 'x' for no preference."
  puts "menu - show this menu again"
  puts "quit\n\n"
end
menu

while input[0] != "quit"
  print "Input: "

  input = Shellwords.split(gets.chomp)

  case input[0]
  when "clear"
    db.clear
    puts "Database cleared.\n\n"
  when "menu"
    menu
  when "import"
    result = AdPredictor::ImportCSV.run(path: input[1])
    if result.error
      puts result.error + "\n\n"
    else
      puts "#{result.records_imported} records imported.\n\n"
      puts "#{result.records_rejected} records rejected.\n\n"
    end
  when "ad"
    params = {}
    params[:hour] = input[1] unless input[1] == 'x'
    params[:browser] = input[2].gsub("'", "") unless input[2].gsub("'", "") == 'x'
    params[:platform] = input[3].gsub("'", "") unless input[3].gsub("'", "") == 'x'
    params[:region] = input [4].gsub("'", "") unless input [4].gsub("'", "") == 'x'
    result = AdPredictor::GetAd.run(params)
    if result.error
      puts result.error + "\n\n"
    else
      puts "Suggested ad: #{result.ad}"
      puts "Expected clickthrough: #{result.clickthrough}\n\n"
    end
  end
end


