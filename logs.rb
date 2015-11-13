require_relative './log_stats'

parser = LogStats.new

parser.results(ARGV[0]).each do |k,v|
  puts "#{k} had #{v} drops"
end

