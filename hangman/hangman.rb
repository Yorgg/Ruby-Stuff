require_relative'game_logic'
 
puts "load previous game? yes/no"
input = gets.chomp
game = input == 'yes' ? Game.new.load : Game.new 
game.start_game


