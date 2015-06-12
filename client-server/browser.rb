require_relative 'connection' 
require 'socket'
require 'json'
 
loop do  
  client = Connection.new
  puts 'Choose an option:'
  puts '1 - GET request'
  puts '2 - POST request'
  puts '3 - Exit'
  input = gets.chomp
  case input
    when '1' then client.get_request    
    when '2' then client.post_request
    when '3' then break  
  end
end

puts "..Browser closed"

